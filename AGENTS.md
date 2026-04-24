# AGENTS.md — Conft

## Project Overview

- **Name**: Conft
- **Description**: Configuration management toolkit with multi-language bindings
- **Location**: `/Users/kooshapari/CodeProjects/Phenotype/repos/Conft`
- **Language Stack**: Rust (primary), TypeScript (bindings)
- **Published**: Internal (Phenotype ecosystem)

## Quick Start Commands

```bash
# Build Rust components
cd /Users/kooshapari/CodeProjects/Phenotype/repos/Conft/rust

# Check available commands
cat README.md

# Build configuration crate
cd /Users/kooshapari/CodeProjects/Phenotype/repos/Conft/rust/phenotype-config
cargo build
```

## Architecture

```
Conft/
├── rust/                       # Rust implementation
│   └── phenotype-config/       # Core config crate (has own AGENTS.md)
├── typescript/                 # TypeScript bindings
├── README.md                   # Project overview
└── VERSION                     # Version tracking
```

## Quality Standards

### Rust Components
- **Line length**: 100 characters
- **Formatter**: `cargo fmt`
- **Linter**: `cargo clippy -- -D warnings`
- **Tests**: `cargo test`

### TypeScript Components
- **Formatter**: `prettier` (if configured)
- **Linter**: `eslint` (if configured)
- **Type checker**: `tsc --noEmit`

## Git Workflow

### Branch Naming
Format: `conft/<type>/<description>`

Types: `feat`, `fix`, `chore`, `docs`, `refactor`, `test`

Examples:
- `conft/feat/rust-config-v2`
- `conft/fix/ts-bindings`

### Commit Format
```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

## File Structure

```
Conft/
├── rust/
│   └── phenotype-config/       # Rust config crate
│       ├── Cargo.toml
│       ├── src/
│       └── AGENTS.md         # Crate-specific rules
├── typescript/               # TS bindings (TBD)
├── README.md
└── VERSION
```

## CLI Commands

```bash
# Rust builds
cd rust/phenotype-config && cargo build
cd rust/phenotype-config && cargo test
cd rust/phenotype-config && cargo clippy

# Version management
cat VERSION
```

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Rust build fails | Check `rust/phenotype-config/AGENTS.md` |
| Missing dependencies | Check `Cargo.toml` in respective crate |
| Version mismatch | Verify `VERSION` file matches crate versions |

## Dependencies

- **AgilePlus**: Work tracking in `/Users/kooshapari/CodeProjects/Phenotype/repos/AgilePlus`
- **HexaKit**: Config traits and interfaces
- **crates/**: Related phenotype crates

## Related Projects

- `crates/phenotype-config/` - Canonical crate location
- `phenotype-config-ts/` - TypeScript implementation

## Agent Notes

When working in Conft:
1. Check if work belongs in `rust/phenotype-config/` (canonical crate)
2. Or in TypeScript bindings (if they exist)
3. Or at this root level for cross-cutting concerns
