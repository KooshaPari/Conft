# Conft

**Status:** active (maintenance mode — TypeScript package, npm publish not yet automated)

**TypeScript Configuration Management with Zod Validation**

A hexagonal architecture-based configuration library providing consistent, type-safe
configuration management for TypeScript/Node.js applications.

> **Note:** This repository currently ships one implementation: `@phenotype/config-ts`
> (TypeScript). A Rust crate (`configkit`) is planned but not yet implemented — the
> `rust/` directory does not exist in this repository.

## Philosophy

Configuration should be:

- **Layered**: Multiple sources with clear precedence
- **Validated**: Schema-based validation at load time
- **Type-safe**: Compile-time guarantees, runtime safety
- **Extensible**: Port/adapter pattern for new sources

## Package

| Language | Package | Location |
|----------|---------|----------|
| **TypeScript** | `@phenotype/config-ts` | `typescript/packages/conft/` |

## Features

- ✅ **Layered Configuration** — File → Env → CLI precedence
- ✅ **Multiple Formats** — TOML, YAML, JSON, ENV
- ✅ **Schema Validation** — Zod-based, type-safe with custom validators
- ✅ **Environment Support** — Dev/staging/prod profiles
- ✅ **Secrets Management** — Secure credential handling
- 🔄 **Hot Reload** — Planned (file-watcher integration)
- 🔄 **Remote Config** — Planned (etcd, Consul)
- 🔄 **Config Versioning** — Planned
- 🔄 **Rust crate (`configkit`)** — Planned, not yet implemented

## Quick Start

```typescript
import { ConfigBuilder } from '@phenotype/config-ts';

const config = await ConfigBuilder
  .fromFile('config.json')
  .withEnv()
  .withCliArgs()
  .build();

const dbUrl = config.get<string>('database.url');
```

## Architecture

The TypeScript implementation follows hexagonal architecture:

```
┌─────────────────────────────────────────────────────────┐
│                      Conft Framework                      │
│                                                         │
│  ┌───────────────────────────────────────────────────┐  │
│  │              Application Layer                     │  │
│  │         (Builder, Loader, ConfigManager)          │  │
│  └───────────────────────────────────────────────────┘  │
│                         │                               │
│  ┌───────────────────────────────────────────────────┐  │
│  │                Domain Layer                        │  │
│  │  ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌────────┐ │  │
│  │  │  Config │ │  Layer  │ │  Source │ │ Schema │ │  │
│  │  └─────────┘ └─────────┘ └─────────┘ └────────┘ │  │
│  └───────────────────────────────────────────────────┘  │
│                         │                               │
│  ┌───────────────────────────────────────────────────┐  │
│  │              Adapter Layer                         │  │
│  │  ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌────────┐ │  │
│  │  │  File   │ │   Env   │ │   CLI   │ │ Remote │ │  │
│  │  └─────────┘ └─────────┘ └─────────┘ └────────┘ │  │
│  └───────────────────────────────────────────────────┘  │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

## Development

```bash
cd typescript/packages/conft/
npm install
npm test
npm run lint
npm run typecheck
npm run build
```

## License

MIT OR Apache-2.0
