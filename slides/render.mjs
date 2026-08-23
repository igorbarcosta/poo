import {
  accessSync,
  constants,
  existsSync,
  linkSync,
  mkdtempSync,
  mkdirSync,
  readFileSync,
  renameSync,
  rmSync,
} from "node:fs";
import { spawn } from "node:child_process";
import { release } from "node:os";
import { basename, dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { PDFDocument } from "pdf-lib";

const slug = process.argv[2];

if (!slug || !/^[a-z0-9][a-z0-9-]*$/.test(slug)) {
  console.error("Uso: bash slides/render.sh <slug-da-aula>");
  process.exit(1);
}

const repositoryRoot = resolve(dirname(fileURLToPath(import.meta.url)), "..");
const source = resolve(repositoryRoot, "slides", `${slug}.md`);
const theme = resolve(repositoryRoot, "slides/theme/poo.css");
const outputDirectory = resolve(repositoryRoot, "slides/rendered");
const temporaryDirectory = resolve(repositoryRoot, ".slides-build/tmp");
const marpCli = resolve(
  repositoryRoot,
  "node_modules/@marp-team/marp-cli/marp-cli.js",
);
const externalProcessTimeoutMs = 120_000;
const terminationGraceMs = 3_000;

for (const [label, path] of [
  ["deck", source],
  ["tema", theme],
  ["Marp CLI", marpCli],
]) {
  if (!existsSync(path)) {
    console.error(`Preflight falhou: ${label} não encontrado em ${path}`);
    process.exit(1);
  }
}

const browser = findLinuxBrowser();
if (!browser) {
  console.error(
    "Preflight falhou: nenhum browser Linux compatível foi encontrado. Disponibilize Chrome, Chromium ou Firefox no PATH, ou informe SLIDES_BROWSER_PATH.",
  );
  process.exit(1);
}

mkdirSync(outputDirectory, { recursive: true });
mkdirSync(temporaryDirectory, { recursive: true });

console.log("Preflight de renderização:");
console.log(`- Node.js: ${process.version} (${process.execPath})`);
console.log(`- Plataforma: ${process.platform}; kernel: ${release()}`);
console.log("- Marp CLI e dependências do projeto: disponíveis");
console.log(`- Browser Linux: ${browser.kind} (${browser.path})`);

const htmlDestination = resolve(outputDirectory, `${slug}.html`);
const pdfDestination = resolve(outputDirectory, `${slug}.pdf`);
const stagingDirectory = mkdtempSync(
  resolve(outputDirectory, `.render-${slug}-`),
);
const stagedHtml = resolve(stagingDirectory, `${slug}.html`);
const stagedPdf = resolve(stagingDirectory, `${slug}.pdf`);
let stagingCleanupSafe = true;

try {
  console.log(`Gerando HTML temporário: ${stagedHtml}`);
  const htmlResult = await runMarp("--html", stagedHtml);
  reportProcessFailure("Não foi possível executar o Marp", htmlResult);
  if (htmlResult.status !== 0) {
    throw new Error(`A exportação HTML falhou com status ${htmlResult.status}.`);
  }

  console.log(`Gerando PDF temporário: ${stagedPdf}`);
  const pdfResult = await runMarp("--pdf", stagedPdf, true);
  reportProcessFailure("Não foi possível executar o Marp", pdfResult);

  if (pdfResult.stdout) process.stdout.write(pdfResult.stdout);
  if (pdfResult.stderr) process.stderr.write(pdfResult.stderr);
  if (pdfResult.status !== 0) {
    throw new Error(
      `A exportação PDF com o browser Linux falhou com status ${pdfResult.status}.`,
    );
  }

  await validateArtifactConsistency(source, stagedHtml, stagedPdf);
  promoteArtifactSet(
    [
      [stagedHtml, htmlDestination],
      [stagedPdf, pdfDestination],
    ],
    stagingDirectory,
  );
  console.log(`Artefatos oficiais promovidos: slides/rendered/${slug}.{html,pdf}`);
} catch (error) {
  if (error?.preserveStaging === true) stagingCleanupSafe = false;
  console.error(error instanceof Error ? error.message : String(error));
  process.exitCode = 1;
} finally {
  if (stagingCleanupSafe) {
    rmSync(stagingDirectory, { recursive: true, force: true });
  }
}

function findLinuxBrowser() {
  const configured = process.env.SLIDES_BROWSER_PATH;
  if (configured) {
    const path = resolve(configured);
    if (!isExecutable(path)) {
      console.error(`SLIDES_BROWSER_PATH não é executável: ${path}`);
      process.exit(1);
    }
    return { kind: browserKind(path), path };
  }

  const candidates = [
    ["chrome", "google-chrome-stable"],
    ["chrome", "google-chrome"],
    ["chrome", "chromium"],
    ["chrome", "chromium-browser"],
    ["firefox", "firefox"],
    ["firefox", "firefox-esr"],
  ];
  const directories = (process.env.PATH ?? "").split(":").filter(Boolean);
  for (const [kind, executable] of candidates) {
    for (const directory of directories) {
      const path = resolve(directory, executable);
      if (isExecutable(path)) return { kind, path };
    }
  }
  return undefined;
}

function browserKind(path) {
  const name = basename(path).toLowerCase();
  if (name.includes("firefox")) return "firefox";
  if (name.includes("edge")) return "edge";
  return "chrome";
}

function isExecutable(path) {
  try {
    accessSync(path, constants.X_OK);
    return true;
  } catch {
    return false;
  }
}

async function runMarp(flag, destination, capture = false) {
  const browserArguments = flag === "--pdf"
    ? ["--browser", browser.kind, "--browser-path", browser.path]
    : [];
  return await runManagedProcess(
    process.execPath,
    [
      marpCli,
      source,
      "--theme-set",
      theme,
      flag,
      ...browserArguments,
      "--output",
      destination,
    ],
    {
      cwd: repositoryRoot,
      echoOutput: !capture,
      env: {
        ...process.env,
        TMPDIR: temporaryDirectory,
        TEMP: temporaryDirectory,
        TMP: temporaryDirectory,
      },
    },
  );
}

function reportProcessFailure(label, result) {
  if (result.terminationConfirmed === false) {
    const error = new Error(
      `${label}: o encerramento completo do grupo de processos não pôde ser confirmado; ainda pode existir processo escrevendo nos arquivos. A tentativa temporária foi preservada em ${stagingDirectory}.`,
    );
    error.preserveStaging = true;
    throw error;
  }
  if (result.timedOut) {
    throw new Error(
      `${label}: tempo limite de ${externalProcessTimeoutMs / 1_000} s excedido; a tentativa temporária será descartada.`,
    );
  }
  if (result.error) {
    throw new Error(`${label}: ${result.error.message}`);
  }
}

function promoteArtifactSet(artifacts, backupDirectory) {
  const backups = [];
  let promoted = 0;

  try {
    for (const [, destination] of artifacts) {
      if (!existsSync(destination)) {
        backups.push(undefined);
        continue;
      }
      const backup = resolve(
        backupDirectory,
        `official-${backups.length}.backup`,
      );
      linkSync(destination, backup);
      backups.push(backup);
    }
    for (const [staged, destination] of artifacts) {
      renameSync(staged, destination);
      promoted += 1;
    }
  } catch (error) {
    for (let index = 0; index < promoted; index += 1) {
      const destination = artifacts[index][1];
      const backup = backups[index];
      if (backup) renameSync(backup, destination);
      else rmSync(destination, { force: true });
    }
    throw new Error(
      `Falha ao promover os artefatos; a distribuição oficial anterior foi restaurada: ${
        error instanceof Error ? error.message : String(error)
      }`,
    );
  } finally {
    for (const backup of backups) {
      if (backup) rmSync(backup, { force: true });
    }
  }
}

function delay(milliseconds) {
  return new Promise((resolveDelay) => setTimeout(resolveDelay, milliseconds));
}

async function raceWithTimeout(completion, timeoutMs, timeoutResult) {
  let timer;
  try {
    return await Promise.race([
      completion,
      new Promise((resolveTimeout) => {
        timer = setTimeout(() => resolveTimeout(timeoutResult), timeoutMs);
      }),
    ]);
  } finally {
    clearTimeout(timer);
  }
}

function processGroupExists(processGroupId) {
  try {
    process.kill(-processGroupId, 0);
    return true;
  } catch (error) {
    return error?.code === "EPERM";
  }
}

function signalProcessGroup(processGroupId, signal) {
  try {
    process.kill(-processGroupId, signal);
  } catch (error) {
    if (error?.code !== "ESRCH") throw error;
  }
}

async function waitForProcessGroupExit(processGroupId, timeoutMs) {
  const deadline = Date.now() + timeoutMs;
  while (processGroupExists(processGroupId) && Date.now() < deadline) {
    await delay(50);
  }
  return !processGroupExists(processGroupId);
}

async function terminateProcessGroup(processGroupId, completion) {
  signalProcessGroup(processGroupId, "SIGTERM");
  const graceful = await raceWithTimeout(
    completion.then(() => true),
    terminationGraceMs,
    false,
  );
  if (!graceful || processGroupExists(processGroupId)) {
    signalProcessGroup(processGroupId, "SIGKILL");
  }
  await completion;
  let ended = await waitForProcessGroupExit(processGroupId, terminationGraceMs);
  if (!ended) {
    signalProcessGroup(processGroupId, "SIGKILL");
    ended = await waitForProcessGroupExit(processGroupId, terminationGraceMs);
  }
  return ended;
}

async function runManagedProcess(command, args, options = {}) {
  const child = spawn(command, args, {
    cwd: options.cwd,
    detached: true,
    env: options.env,
    stdio: ["ignore", "pipe", "pipe"],
  });
  let stdout = "";
  let stderr = "";
  child.stdout.on("data", (chunk) => {
    const text = chunk.toString();
    stdout += text;
    if (options.echoOutput) process.stdout.write(text);
  });
  child.stderr.on("data", (chunk) => {
    const text = chunk.toString();
    stderr += text;
    if (options.echoOutput) process.stderr.write(text);
  });

  const completion = new Promise((resolveCompletion) => {
    child.once("error", (error) =>
      resolveCompletion({ error, status: null, signal: null })
    );
    child.once("close", (status, signal) =>
      resolveCompletion({ error: undefined, status, signal })
    );
  });
  const outcome = await raceWithTimeout(
    completion,
    externalProcessTimeoutMs,
    { timedOut: true },
  );

  if (outcome.timedOut) {
    const terminationConfirmed = await terminateProcessGroup(child.pid, completion);
    return { stdout, stderr, timedOut: true, terminationConfirmed };
  }

  if (child.pid && processGroupExists(child.pid)) {
    const terminationConfirmed = await terminateProcessGroup(child.pid, completion);
    return {
      ...outcome,
      stdout,
      stderr,
      timedOut: false,
      terminationConfirmed,
      error: new Error("O processo principal terminou, mas deixou descendentes ativos."),
    };
  }
  return { ...outcome, stdout, stderr, timedOut: false };
}

function countSourceSlides(markdown) {
  const lines = markdown.split(/\r?\n/);
  let index = 0;
  if (lines[0]?.trim() === "---") {
    index = lines.findIndex((line, position) =>
      position > 0 && line.trim() === "---"
    ) + 1;
  }

  let separators = 0;
  let fence = null;
  for (; index < lines.length; index += 1) {
    const line = lines[index];
    const fenceMatch = line.match(/^\s*(```+|~~~+)/);
    if (fenceMatch) {
      fence = fence ? null : fenceMatch[1][0];
      continue;
    }
    if (!fence && line.trim() === "---") separators += 1;
  }
  return separators + 1;
}

function countHtmlSlides(html) {
  return html.match(/<section\b/g)?.length ?? 0;
}

async function countPdfPages(pdf) {
  const document = await PDFDocument.load(pdf, { updateMetadata: false });
  return document.getPageCount();
}

async function validateArtifactConsistency(markdownPath, htmlPath, pdfPath) {
  const sourceSlides = countSourceSlides(readFileSync(markdownPath, "utf8"));
  const htmlSlides = countHtmlSlides(readFileSync(htmlPath, "utf8"));
  const pdfPages = await countPdfPages(readFileSync(pdfPath));

  console.log(
    `Consistência: fonte=${sourceSlides}, HTML=${htmlSlides}, PDF=${pdfPages}`,
  );
  if (sourceSlides !== htmlSlides || htmlSlides !== pdfPages) {
    throw new Error("Falha de consistência entre fonte, HTML e PDF.");
  }
}
