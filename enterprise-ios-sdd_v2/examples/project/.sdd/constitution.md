# Project Constitution

This document contains non-negotiable engineering principles for the application.

## Architecture

- Respect approved module/layer boundaries.
- Do not bypass dependency-injection boundaries without an approved exception.

## Product Intent

- Do not invent product behavior.
- Ambiguous requirements require clarification.

## Testing

- New business behavior requires automated validation.
- Regressions require regression tests.

## Dependencies

- New dependencies require review and explicit approval.

## Security

- Never commit secrets.
- Never put production/customer-sensitive data into SDD artifacts.

## AI Development

- The repository specification is the source of truth.
- Agents must produce evidence for completion.
- A changed feature plan invalidates prior convergence assumptions.
