FROM n8nio/n8n

ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV N8N_PROTOCOL=https
ENV NODE_ENV=production
ENV GENERIC_TIMEZONE=America/Guayaquil

EXPOSE 5678

# copiar workflows del repo
COPY workflows /workflows

# importar workflows y arrancar n8n
CMD n8n import:workflow --input=/workflows --separate && n8n start
