# Security

- Never commit secrets or production credentials.
- Do not write Apple IDs, receipts, transaction identifiers, or emails into SDD files or status messages.
- Restore reads the current Apple ID's entitlements through StoreKit on device. The sample does not upload them.
- The status string shown to the user is one of a fixed set. It does not include store error payloads.
