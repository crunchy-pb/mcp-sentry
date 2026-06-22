# Sentry MCP Server Container

Production container packaging for the official `@sentry/mcp-server` package.

## Build

```bash
docker build -t mcp-sentry:local .
```

The runtime pins Node, Alpine, npm, and `@sentry/mcp-server` versions in `package.json` and the Docker build arguments.

## Run

Pass the environment expected by `@sentry/mcp-server` for your MCP transport and Sentry authentication configuration:

```bash
docker run --rm -i \
  -e SENTRY_AUTH_TOKEN=your-token \
  mcp-sentry:local
```

## Releases

Releases are automated by semantic-release from conventional commits. The release workflow:

1. calculates the next semantic version,
2. updates `package.json`, `package-lock.json` when present, and `CHANGELOG.md`,
3. creates a GitHub release,
4. builds and publishes a production image to GitHub Container Registry.

Dependency updates are automated with Renovate for npm packages, Docker versions, and GitHub Actions.
