# Conft

**Universal Configuration Management with Cross-Language Support**

A hexagonal architecture-based configuration framework providing consistent, type-safe configuration management across Rust and TypeScript.

## Philosophy

Configuration should be:
- **Layered**: Multiple sources with clear precedence
- **Validated**: Schema-based validation at load time
- **Type-safe**: Compile-time guarantees, runtime safety
- **Portable**: Same patterns across languages

## Languages

| Language | Package | Location | Features |
|----------|---------|----------|----------|
| **Rust** | `configkit` | `rust/phenotype-config/` | Serde-based, hot reload |
| **TypeScript** | `@phenotype/config-ts` | `typescript/packages/conft/` | Zod validation, async |

## Features

- ✅ **Layered Configuration** - File → Env → CLI precedence
- ✅ **Multiple Formats** - TOML, YAML, JSON, ENV
- ✅ **Schema Validation** - Type-safe with custom validators
- ✅ **Hot Reload** - Watch and reload config files
- ✅ **Environment Support** - Dev/staging/prod profiles
- ✅ **Secrets Management** - Secure credential handling
- 🔄 **Remote Config** - Planned (etcd, Consul)
- 🔄 **Config Versioning** - Planned

## Quick Start

### Rust

```rust
use configkit::{Config, ConfigBuilder};

let config = ConfigBuilder::new()
    .with_file("config.toml")?
    .with_env()
    .with_cli_args()
    .build()?;

let db_url: String = config.get("database.url")?;
```

### TypeScript

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

Both implementations follow hexagonal architecture:

```
┌─────────────────────────────────────────────────────────┐
│                      Conft Framework                      │
│                                                         │
│  ┌───────────────────────────────────────────────────┐  │
│  │              Application Layer                     │  │
│  │         (Builder, Loader, Watcher)               │  │
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

### Rust

```bash
cd rust/phenotype-config/
cargo build
cargo test
cargo clippy -- -D warnings
```

### TypeScript

```bash
cd typescript/packages/conft/
npm install
npm test
npm run lint
```

## Governance & Contribution

**AgilePlus Tracking**: All work tracked in `/repos/AgilePlus`. Review `CLAUDE.md` for governance and development contracts.

**Quality Standards**: All implementations must pass language-specific linters, formatters, and comprehensive test suites.

**Cross-Language Consistency**: Configuration APIs and behavior patterns are standardized across Rust and TypeScript to ensure portable application code.

## Usage Patterns

Conft powers consistent configuration management across the Phenotype ecosystem. Applications can switch between Rust and TypeScript implementations without changing configuration structure or precedence rules.

**Example Use Cases**:
- Multi-tenant SaaS configuration (environment-specific profiles)
- Agent deployment configurations (provider selection, cost limits)
- Service mesh configuration (ingress rules, policy enforcement)

## Related Phenotype Projects

- **[phenotype-shared](../phenotype-shared)** — Shared infrastructure utilities
- **[cloud](../cloud)** — Multi-tenant SaaS backend using Conft
- **[AgilePlus](../AgilePlus)** — Configuration governance

## License

MIT — see [LICENSE](./LICENSE).

**Status**: Active development (Phase 2 planned)  
**Maintained by**: Phenotype Org  
**Last Updated**: 2026-04-24
