import { existsSync, mkdirSync } from "node:fs";
import { spawnSync } from "node:child_process";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";

const slug = process.argv[2];

if (!slug || !/^[a-z0-9][a-z0-9-]*$/.test(slug)) {
  console.error("Uso: npm run slides:render -- <slug-da-aula>");
  process.exit(1);
}

const repositoryRoot = resolve(dirname(fileURLToPath(import.meta.url)), "..");
const source = resolve(repositoryRoot, "slides", `${slug}.md`);
const theme = resolve(repositoryRoot, "slides/theme/poo.css");
const outputDirectory = resolve(repositoryRoot, "slides/rendered");

if (!existsSync(source)) {
  console.error(`Deck não encontrado: slides/${slug}.md`);
  process.exit(1);
}

mkdirSync(outputDirectory, { recursive: true });

const outputs = [
  { format: "HTML", flag: "--html", extension: "html" },
  { format: "PDF", flag: "--pdf", extension: "pdf" },
];

for (const output of outputs) {
  const destination = resolve(outputDirectory, `${slug}.${output.extension}`);
  console.log(`Gerando ${output.format}: slides/rendered/${slug}.${output.extension}`);

  const result = spawnSync(
    "marp",
    [source, "--theme-set", theme, output.flag, "--output", destination],
    { cwd: repositoryRoot, stdio: "inherit" },
  );

  if (result.error) {
    console.error(`Não foi possível executar o Marp: ${result.error.message}`);
    process.exit(1);
  }

  if (result.status !== 0) {
    process.exit(result.status ?? 1);
  }
}
