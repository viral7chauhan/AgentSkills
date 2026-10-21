# MCP recommendations

MCP is an integration layer for context and actions. Build, test, and quality decisions stay in scripts and CI.

## Workflow

1. Run `./scripts/sdd-mcp-recommend` for the project, or `./scripts/sdd-mcp-recommend --feature FTR-###` for one feature. It reads `.sdd/project/tech-stack.md`, `tech-stack.yaml`, the feature `spec.md` and `plan.md`, and `.sdd/mcp-registry.yaml`.
2. Keep only servers that map to a real capability the project or feature needs.
3. Prefer official or vendor-maintained servers.
4. Grant least privilege: read-only for discovery and review, write access only with explicit human approval.
5. Record each recommendation with its rationale and permission scope. The script recommends; it never installs.

Done when every recommended server has a stated capability, source, and permission scope, and none replaces a CI gate.

## Typical mappings

| Server | Use for |
| --- | --- |
| GitHub | Repository, issues, PRs, Actions, code security, releases |
| Figma | Design system, components, variables, design-to-code context |
| Linear | Product and issue context, when the team plans in Linear |
| Firebase | Firestore and backend context, when Firebase is in the stack |
| Playwright | Web or admin portals; native iOS UI stays on XCUITest |
| Internal iOS build/simulator | Only a trusted internal server; otherwise `xcodebuild`, `xcrun simctl`, and CI |

Re-run recommendations whenever the tech stack or a feature's plan changes.
