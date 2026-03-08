#!/bin/sh
set -e

echo "DB_TYPE=$DB_TYPE"
echo "DB_POSTGRESDB_HOST=$DB_POSTGRESDB_HOST"
echo "DB_POSTGRESDB_PORT=$DB_POSTGRESDB_PORT"
echo "DB_POSTGRESDB_DATABASE=$DB_POSTGRESDB_DATABASE"
echo "DB_POSTGRESDB_USER=$DB_POSTGRESDB_USER"

echo "Importando workflows desde /workflows..."

if [ -d /workflows ]; then
  for file in /workflows/*.json; do
    if [ -f "$file" ]; then
      echo "Importando $file"
      n8n import:workflow --input="$file" || echo "No se pudo importar $file, continúo..."
    fi
  done
fi

echo "Activando workflows..."
n8n update:workflow --all --active=true || echo "No se pudieron activar todos los workflows, continúo..."

echo "Iniciando n8n..."
exec n8n start
