# Conft - Project Plan

**Document ID**: PLAN-CONFT-001  
**Version**: 1.0.0  
**Created**: 2026-04-05  
**Status**: Draft  
**Project Owner**: Phenotype Configuration Team  
**Review Cycle**: Monthly

---

## 1. Project Overview & Objectives

### 1.1 Vision Statement

Conft (Configuration Toolkit) is Phenotype's unified configuration management system - a declarative, type-safe, and environment-aware configuration framework that supports multiple formats, validation, hot-reloading, and secure secret management across all Phenotype services and applications.

### 1.2 Mission Statement

To provide a consistent, reliable configuration experience that eliminates configuration drift, enables safe configuration changes, and provides complete visibility into configuration state across the entire Phenotype ecosystem.

### 1.3 Core Objectives

| Objective ID | Description | Success Criteria | Priority |
|--------------|-------------|------------------|----------|
| OBJ-001 | Multi-format support | YAML, TOML, JSON, env | P0 |
| OBJ-002 | Type-safe configs | Compile-time validation | P0 |
| OBJ-003 | Environment layering | dev/staging/prod configs | P0 |
| OBJ-004 | Hot reloading | No restart config updates | P1 |
| OBJ-005 | Secret integration | Vault, AWS Secrets Manager | P1 |
| OBJ-006 | Validation framework | Schema validation | P0 |
| OBJ-007 | Config diff/migration | Track config changes | P2 |
| OBJ-008 | UI management | Web-based config editor | P2 |
| OBJ-009 | GitOps workflow | Config in version control | P1 |
| OBJ-010 | Audit logging | Config change tracking | P1 |

### 1.4 Problem Statement

Configuration challenges across Phenotype:
- Inconsistent config formats between services
- Configuration scattered across repositories
- Secrets mixed with configuration
- No validation of configuration values
- Manual configuration updates
- Difficulty tracking config changes
- Environment-specific configuration complexity
- No rollback capability for config changes

### 1.5 Target Users

1. **Service Developers**: Configuring their applications
2. **DevOps Engineers**: Managing environment configs
3. **Platform Engineers**: Maintaining config infrastructure
4. **Security Engineers**: Managing secrets
5. **SREs**: Debugging production issues

---

## 2. Architecture Strategy

### 2.1 High-Level Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                     Configuration Stack                         │
├─────────────────────────────────────────────────────────────────┤
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐             │
│  │   Conft     │  │   Conft     │  │   Conft     │             │
│  │   Rust      │  │   Python    │  │   TS/Node   │             │
│  │   Library   │  │   Library   │  │   Library   │             │
│  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘             │
│         └──────────────────┼──────────────────┘                  │
│                            │                                     │
│                   ┌────────▼────────┐                          │
│                   │  Conft Server     │                          │
│                   │  (Config API)     │                          │
│                   └────────┬────────┘                          │
│         ┌──────────────────┼──────────────────┐                 │
│         │                  │                  │                 │
│  ┌──────▼──────┐   ┌──────▼──────┐   ┌──────▼──────┐           │
│  │   Config    │   │   Secret    │   │   Schema    │           │
│  │   Storage   │   │   Manager   │   │   Registry  │           │
│  │             │   │             │   │             │           │
│  │  Git repo   │   │  Vault      │   │  Definitions│           │
│  │  S3         │   │  AWS SM     │   │  Validation │           │
│  │  Database   │   │  GCP SM     │   │  Docs       │           │
│  └─────────────┘   └─────────────┘   └─────────────┘           │
│                                                                 │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │                  Conft UI                              │   │
│  │  - Config editor  - Diff viewer  - Audit log  - Schema   │   │
│  └─────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────┘
```

### 2.2 Configuration Hierarchy

```yaml
# Base configuration (config/base.yaml)
service:
  name: my-service
  version: "1.0.0"
  
server:
  port: 8080
  timeout: 30s

# Environment override (config/dev.yaml)
environment: dev
server:
  port: 3000  # Override base
  debug: true  # Add new

database:
  host: localhost
  pool_size: 5

# Secrets (resolved at runtime)
database:
  password: ${vault:secret/data/db#password}
  
# Final merged config (in memory)
environment: dev
service:
  name: my-service
  version: "1.0.0"
server:
  port: 3000
  timeout: 30s
  debug: true
database:
  host: localhost
  pool_size: 5
  password: "actual-secret-from-vault"
```

### 2.3 Component Architecture

| Component | Technology | Purpose |
|-----------|------------|---------|
| conft-core | Rust | Config parsing, merging |
| conft-schema | Rust | Schema validation |
| conft-secrets | Rust | Secret resolution |
| conft-reload | Rust | Hot reload |
| conft-server | Rust | Config API server |
| conft-ui | React | Web management UI |
| conft-cli | Rust | Command-line tool |
| conft-python | Python | Python SDK |
| conft-node | TypeScript | Node.js SDK |

---

## 3. Implementation Phases

### 3.1 Phase 0: Core Parser (Weeks 1-4)

| Week | Deliverable | Owner |
|------|-------------|-------|
| 1 | YAML/TOML/JSON parsing | Core Team |
| 2 | Config merging | Core Team |
| 3 | Environment layering | Core Team |
| 4 | CLI tool | Core Team |

### 3.2 Phase 1: Validation & Schema (Weeks 5-10)

| Week | Deliverable | Owner |
|------|-------------|-------|
| 5-6 | Schema definition DSL | Schema Team |
| 7-8 | Validation engine | Validation Team |
| 9-10 | Error reporting | Core Team |

### 3.3 Phase 2: Secrets & Reloading (Weeks 11-16)

| Week | Deliverable | Owner |
|------|-------------|-------|
| 11-12 | Vault integration | Security Team |
| 13-14 | Cloud secret managers | Cloud Team |
| 15-16 | Hot reload | Core Team |

### 3.4 Phase 3: Server & UI (Weeks 17-22)

| Week | Deliverable | Owner |
|------|-------------|-------|
| 17-18 | Config API server | API Team |
| 19-20 | Web UI | Frontend Team |
| 21-22 | Audit logging | Security Team |

### 3.5 Phase 4: Language SDKs (Weeks 23-28)

| Week | Deliverable | Owner |
|------|-------------|-------|
| 23-25 | Python SDK | Python Team |
| 26-28 | TypeScript SDK | TS Team |

---

## 4. Technical Stack Decisions

| Layer | Technology | Rationale |
|-------|------------|-----------|
| Core | Rust | Performance, safety |
| Parsing | serde + toml/yaml | Ecosystem standard |
| Schema | JSON Schema + custom | Flexibility |
| Secrets | Vault API, AWS SDK | Industry standard |
| Reload | notify crate | File watching |
| Server | Axum | Async, Tower |
| UI | React + TypeScript | Type safety |
| Storage | Git, S3 | Existing infra |
| Python | PyO3 bindings | Native feel |
| Node.js | NAPI-RS | Native feel |

---

## 5. Risk Analysis & Mitigation

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| Secret resolution failure | Medium | Critical | Graceful degradation, caching |
| Config merge conflicts | Medium | High | Explicit override rules |
| Schema complexity | Medium | Medium | Gradual adoption |
| Hot reload race conditions | Low | High | Atomic updates |
| Storage backend failures | Low | High | Multiple backends |

---

## 6. Resource Requirements

### 6.1 Team

| Role | Count | Focus |
|------|-------|-------|
| Rust Developer | 2 | Core, server |
| Security Engineer | 1 | Secrets integration |
| Frontend Developer | 1 | Web UI |
| Python Developer | 1 | Python SDK |
| TypeScript Developer | 1 | TS SDK |

### 6.2 Infrastructure

| Resource | Cost/Month |
|----------|------------|
| Config server | $200 |
| Audit log storage | $100 |
| UI hosting | $50 |

---

## 7. Timeline & Milestones

| Milestone | Date | Criteria |
|-----------|------|----------|
| Core Parser | Week 4 | Multi-format support |
| Validation | Week 10 | Schema validation |
| Secrets | Week 16 | Vault integration |
| Server | Week 22 | API + UI |
| SDKs | Week 28 | Python + TS |

---

## 8. Dependencies & Blockers

| Dependency | Required By | Status |
|------------|-------------|--------|
| notify crate | Week 15 | Available |
| Vault SDK | Week 11 | Available |
| phenotype-event-sourcing | Week 21 | In Progress |

---

## 9. Testing Strategy

| Type | Target | Tools |
|------|--------|-------|
| Unit | 85% | cargo test |
| Schema | 100% | Property testing |
| Integration | 80% | Mock secret backends |
| E2E | 60% | Full stack tests |

---

## 10. Deployment Plan

| Phase | Channel | Criteria |
|-------|---------|----------|
| Alpha | Internal | Core parser |
| Beta | 3 teams | Validation |
| Public | All teams | Server + UI |

---

## 11. Rollback Procedures

| Scenario | Action |
|----------|--------|
| Bad config deployed | `conft rollback --version <prev>` |
| Secret resolution fail | Use cached values |
| Schema validation too strict | Emergency bypass flag |

---

## 12. Post-Launch Monitoring

| Metric | Target |
|--------|--------|
| Config load time | <100ms |
| Secret resolution time | <50ms |
| Hot reload latency | <1s |
| Validation errors | Track trends |

---

**Document Control**

- **Status**: Draft
- **Next Review**: 2026-05-05
