#!/usr/bin/env node

import { createHash } from "node:crypto";
import { mkdir, open, readFile, rename, rm, stat } from "node:fs/promises";
import path from "node:path";
import process from "node:process";

import hljs from "highlight.js";
import MarkdownIt from "markdown-it";

const PREVIEW_VERSION = "1";

function usage() {
  return "uso: preview.mjs <generate|check> <diretório-do-instrumento>";
}

function escapeHtml(value) {
  return value
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;");
}

function semanticBody(source) {
  const match = source.match(/^---\r?\n[\s\S]*?\r?\n---\r?\n/);
  if (!match) {
    throw new Error("base.md deve começar com frontmatter YAML");
  }
  return source.slice(match[0].length);
}

function renderer() {
  const markdown = new MarkdownIt({
    html: false,
    linkify: false,
    typographer: false,
    highlight(code, language) {
      if (language && hljs.getLanguage(language)) {
        return `<pre class="hljs"><code>${hljs.highlight(code, { language, ignoreIllegals: true }).value}</code></pre>`;
      }
      return `<pre class="hljs"><code>${markdown.utils.escapeHtml(code)}</code></pre>`;
    },
  });
  return markdown;
}

function renderPreview(source, sourceHash, identifier) {
  const content = renderer().render(semanticBody(source));
  const title = `Preview da base semântica — ${identifier}`;
  return `<!doctype html>
<html lang="pt-BR">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="assessment-source-sha256" content="${sourceHash}">
  <meta name="assessment-preview-version" content="${PREVIEW_VERSION}">
  <title>${escapeHtml(title)}</title>
  <style>
    :root { color-scheme: light; font-family: Inter, ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif; color: #172033; background: #eef2f7; }
    * { box-sizing: border-box; }
    body { margin: 0; padding: 2rem 1rem 4rem; }
    main { max-width: 58rem; margin: 0 auto; padding: 2.5rem 3rem; background: #fff; border: 1px solid #d8dee9; border-radius: 12px; box-shadow: 0 8px 28px rgb(31 41 55 / 8%); }
    .preview-label { margin: 0 0 2rem; padding-bottom: 1rem; color: #526075; border-bottom: 1px solid #e2e7ef; font-size: .9rem; }
    h1, h2, h3 { color: #102a43; line-height: 1.25; }
    h1 { margin-top: 0; font-size: 1.75rem; }
    h2 { margin-top: 2.4rem; padding-top: .6rem; border-top: 1px solid #e5eaf1; font-size: 1.35rem; }
    h3 { margin-top: 1.7rem; font-size: 1.1rem; }
    p, li { line-height: 1.62; }
    table { width: 100%; border-collapse: collapse; margin: 1.25rem 0; }
    th, td { padding: .65rem .75rem; border: 1px solid #d8dee9; text-align: left; vertical-align: top; }
    th { background: #f4f7fa; }
    code { font-family: "JetBrains Mono", "Cascadia Code", Consolas, monospace; font-size: .92em; }
    :not(pre) > code { padding: .12rem .3rem; border-radius: 4px; background: #eef2f6; }
    pre.hljs { overflow-x: auto; margin: 1rem 0 1.4rem; padding: 1rem 1.15rem; border: 1px solid #dbe2ea; border-radius: 8px; background: #f6f8fa; line-height: 1.5; }
    .hljs-keyword, .hljs-type { color: #7c3aed; }
    .hljs-title, .hljs-title.class_, .hljs-title.function_ { color: #075985; }
    .hljs-number, .hljs-literal { color: #b45309; }
    .hljs-string { color: #166534; }
    .hljs-comment { color: #64748b; font-style: italic; }
    footer { max-width: 58rem; margin: 1rem auto 0; color: #68758a; font-size: .8rem; text-align: center; }
    @media (max-width: 700px) { main { padding: 1.5rem 1.2rem; } body { padding: .75rem .5rem 2rem; } }
  </style>
</head>
<body>
  <main>
    <p class="preview-label">Preview derivado de <code>base.md</code> para revisão humana. Não é artefato de aplicação.</p>
${content}  </main>
  <footer>Fonte SHA-256: <code>${sourceHash}</code></footer>
</body>
</html>
`;
}

async function expectedPreview(instrumentDirectory) {
  const basePath = path.join(instrumentDirectory, "base.md");
  const info = await stat(basePath, { bigint: false });
  if (!info.isFile()) {
    throw new Error(`fonte semântica não encontrada: ${basePath}`);
  }
  const source = await readFile(basePath, "utf8");
  const sourceHash = createHash("sha256").update(Buffer.from(source, "utf8")).digest("hex");
  return renderPreview(source, sourceHash, path.basename(instrumentDirectory));
}

async function atomicWrite(destination, content) {
  const directory = path.dirname(destination);
  const temporary = path.join(directory, `.base.html.${process.pid}.tmp`);
  let handle;
  try {
    handle = await open(temporary, "wx", 0o644);
    await handle.writeFile(content, "utf8");
    await handle.sync();
    await handle.close();
    handle = undefined;
    await rename(temporary, destination);
  } catch (error) {
    if (handle) await handle.close();
    await rm(temporary, { force: true });
    throw error;
  }
}

async function main() {
  const [command, directoryArgument] = process.argv.slice(2);
  if (!new Set(["generate", "check"]).has(command) || !directoryArgument) {
    throw new Error(usage());
  }
  const instrumentDirectory = path.resolve(directoryArgument);
  const previewDirectory = path.join(instrumentDirectory, "preview");
  const previewPath = path.join(previewDirectory, "base.html");
  const expected = await expectedPreview(instrumentDirectory);

  if (command === "generate") {
    await mkdir(previewDirectory, { recursive: true });
    await atomicWrite(previewPath, expected);
    console.log(`preview gerado: ${previewPath}`);
    return;
  }

  let current;
  try {
    current = await readFile(previewPath, "utf8");
  } catch (error) {
    if (error.code === "ENOENT") {
      throw new Error(`preview ausente: ${previewPath}; execute o comando generate`);
    }
    throw error;
  }
  if (current !== expected) {
    throw new Error(`preview divergente de base.md: ${previewPath}; regenere antes da revisão ou aprovação`);
  }
  console.log(`preview íntegro: ${previewPath}`);
}

main().catch((error) => {
  console.error(`erro: ${error.message}`);
  process.exitCode = 1;
});
