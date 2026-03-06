FROM node:20-alpine

RUN apk add --no-cache tini bash \
 && npm install -g n8n

ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV N8N_PROTOCOL=https
ENV NODE_ENV=production
ENV GENERIC_TIMEZONE=America/Guayaquil

EXPOSE 5678

COPY workflows /workflows
COPY start.sh /start.sh

RUN chmod +x /start.sh

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/bin/sh", "/start.sh"]
