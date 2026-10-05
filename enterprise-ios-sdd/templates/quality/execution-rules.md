# Execution Verification Rules

## Principle

A task or plan item is not considered verified because an agent marked it complete. Verification requires evidence.

## Required evidence

Depending on the item, evidence may include:

- expected source/test file exists
- required API/protocol/type exists
- implementation path is identifiable
- automated test exists
- relevant test passes
- CI run passes
- architecture check passes
- no out-of-scope files were changed

## Statuses

- NOT_STARTED
- IN_PROGRESS
- IMPLEMENTED
- VERIFIED
- BLOCKED
- NOT_APPLICABLE

## Rules

1. IMPLEMENTED means the agent believes the work is present in the repository.
2. VERIFIED means required evidence has been observed.
3. A required test that does not exist prevents verification.
4. A required CI gate that has not run prevents verification for that gate.
5. A failed required gate is a blocker unless an explicit human-approved exception exists.
6. Missing or ambiguous evidence must remain unresolved; do not infer success.
7. Scope violations must be surfaced for review.
