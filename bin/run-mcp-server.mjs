#!/usr/bin/env node
import { createRequire } from 'node:module';
import { spawn } from 'node:child_process';
import { dirname, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';

const require = createRequire(import.meta.url);
const packageJsonPath = require.resolve('@sentry/mcp-server/package.json');
const packageJson = require(packageJsonPath);
const packageDir = dirname(packageJsonPath);
const bin = packageJson.bin;
const relativeEntrypoint = typeof bin === 'string' ? bin : bin?.[Object.keys(bin)[0]];

if (!relativeEntrypoint) {
  throw new Error('Unable to find a bin entry in @sentry/mcp-server/package.json');
}

const child = spawn(process.execPath, [resolve(packageDir, relativeEntrypoint), ...process.argv.slice(2)], {
  stdio: 'inherit',
  env: process.env,
});

child.on('exit', (code, signal) => {
  if (signal) {
    process.kill(process.pid, signal);
    return;
  }
  process.exit(code ?? 0);
});
