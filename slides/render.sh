#!/usr/bin/env bash

set -eu

repository_root="$(cd "$(dirname "$0")/.." && pwd)"
node_binary=""
node_version="$(tr -d '[:space:]' < "$repository_root/.nvmrc")"

if command -v node >/dev/null 2>&1; then
  candidate="$(command -v node)"
  candidate_platform="$("$candidate" -p 'process.platform' 2>/dev/null || true)"
  candidate_version="$("$candidate" --version 2>/dev/null || true)"
  if [ "$candidate_platform" = "linux" ] && [ "$candidate_version" = "v${node_version#v}" ]; then
    node_binary="$candidate"
  fi
fi

if [ -z "$node_binary" ]; then
  nvm_root="${NVM_DIR:-$HOME/.nvm}"
  candidate="$nvm_root/versions/node/v${node_version#v}/bin/node"
  if [ -x "$candidate" ]; then
    node_binary="$candidate"
  fi
fi

if [ -z "$node_binary" ]; then
  echo "Node.js Linux não encontrado para renderizar os slides." >&2
  echo "Instale ou disponibilize a versão $node_version indicada em .nvmrc; o script não altera o ambiente automaticamente." >&2
  echo "node observado: $(command -v node 2>/dev/null || echo ausente)" >&2
  echo "npm observado: $(command -v npm 2>/dev/null || echo ausente)" >&2
  exit 1
fi

exec "$node_binary" "$repository_root/slides/render.mjs" "$@"
