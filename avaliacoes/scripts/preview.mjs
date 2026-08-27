import path from "node:path";
import { fileURLToPath, pathToFileURL } from "node:url";

const currentDirectory = path.dirname(fileURLToPath(import.meta.url));
const defaultRoot = path.resolve(currentDirectory, "../../../docemas");
const docemasRoot = process.env.DOCEMAS_ROOT
  ? path.resolve(process.env.DOCEMAS_ROOT)
  : defaultRoot;
const implementation = path.join(
  docemasRoot,
  "assessments",
  "scripts",
  "preview.mjs",
);

await import(pathToFileURL(implementation).href);
