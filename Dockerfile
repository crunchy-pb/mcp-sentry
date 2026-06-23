# syntax=docker/dockerfile:1.7

ARG NODE_VERSION=22.16.0
ARG ALPINE_VERSION=3.22
FROM node:${NODE_VERSION}-alpine${ALPINE_VERSION} AS runtime

ARG INTEGRATION_CONFIG_SCHEMA="{}"

LABEL org.opencontainers.image.title="Sentry MCP Server" \
      org.opencontainers.image.description="Production container for @sentry/mcp-server" \
      org.opencontainers.image.source="https://github.com/getsentry/sentry-mcp" \
      org.opencontainers.image.licenses="MIT" \
      uk.unrtd.pb.integration.name="io.github.getsentry/sentry-mcp" \
      uk.unrtd.pb.integration.config-schema="${INTEGRATION_CONFIG_SCHEMA}"

ENV NODE_ENV=production \
    NPM_CONFIG_UPDATE_NOTIFIER=false \
    NPM_CONFIG_FUND=false \
    NPM_CONFIG_AUDIT=false

WORKDIR /app

COPY package.json ./
COPY bin/run-mcp-server.mjs ./bin/run-mcp-server.mjs

RUN --mount=type=cache,target=/root/.npm \
    npm install --omit=dev --ignore-scripts \
    && npm cache clean --force

USER node

ENTRYPOINT ["node", "/app/bin/run-mcp-server.mjs"]
