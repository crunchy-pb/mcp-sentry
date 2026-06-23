# Sentry MCP Server Container

Production container packaging for the official `@sentry/mcp-server` package.

## Build

```bash
docker build \
  --build-arg INTEGRATION_CONFIG_SCHEMA="$(npm run --silent config-schema:label)" \
  -t mcp-sentry:local .
```

The runtime pins Node, Alpine, npm, and `@sentry/mcp-server` versions in `package.json` and the Docker build arguments.

## Run

Pass the environment expected by `@sentry/mcp-server` for your MCP transport and Sentry authentication configuration:

```bash
docker run --rm -i \
  -e SENTRY_ACCESS_TOKEN=your-token \
  mcp-sentry:local
```

## Container metadata

The image publishes MCP discovery metadata using OCI/Docker labels:

- `uk.unrtd.pb.integration.name` identifies the server as `io.github.getsentry/sentry-mcp`.
- `uk.unrtd.pb.integration.config-schema` contains the JSON Schema from `config.schema.json`, describing supported configuration environment variables, secret fields, enums, URI formats, and mutually exclusive Sentry host settings.

Use `config.schema.json` as the readable source for the embedded label when updating supported environment variables. The `config-schema:label` npm script compacts that schema for the Docker build argument used by CI and release builds.

## Releases

Releases are automated by semantic-release from conventional commits. The release workflow:

1. calculates the next semantic version,
2. updates `package.json`, `package-lock.json` when present, and `CHANGELOG.md`,
3. creates a GitHub release,
4. builds and publishes a production image to GitHub Container Registry.

Dependency updates are automated with Renovate for npm packages, Docker versions, and GitHub Actions.
