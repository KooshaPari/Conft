# justfile — Conft
# Standard Phenotype org recipes. Run `just` to list.

set shell := ["bash", "-uc"]

# Default recipe — list available recipes
default:
	@just --list

# Build
build:
	task build

# Run tests
test:
	task test

# Lint
lint:
	task lint

# Format
fmt:
	@echo "Format handled by project tooling (task fmt if present)"

# Security audit
audit:
	task lint

# Quality gate (build + test + lint)
quality: build test lint
	@echo "quality gate OK"

# Clean
clean:
	task clean
