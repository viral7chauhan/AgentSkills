# Architecture

## Architecture Style

TBD

## Layers / Modules

```text
Presentation → Domain → Data
```

## Dependency Rules

- Presentation must not instantiate infrastructure implementations directly.
- Domain must not depend on UIKit or external SDKs unless explicitly approved.
- Use protocols at architectural boundaries where substitution/testing is required.

## Exception Process

Architecture exceptions require a documented rationale and ADR where appropriate.
