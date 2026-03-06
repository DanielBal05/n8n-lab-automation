#!/bin/sh
set -e

echo "Importando workflows desde /workflows..."

if [ -d /workflows ]; then
  for file in /workflows/*.json; do
    if [ -f "$file" ]; then
      echo "Importando $file"
      n8n import:workflow --input="$file" || echo "No se pudo importar $file, continúo..."
    fi
  done
fi

echo "Iniciando n8n..."
exec n8n start
