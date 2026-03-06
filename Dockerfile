FROM n8nio/n8n

ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV N8N_PROTOCOL=https
ENV NODE_ENV=production
ENV GENERIC_TIMEZONE=America/Guayaquil

EXPOSE 5678

COPY workflows /workflows
COPY start-n8n.js /start-n8n.js

CMD ["node", "/start-n8n.js"]
