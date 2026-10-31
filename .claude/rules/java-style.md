---
paths:
  - "src/**/*.java"
---

<!-- Source: runelite/example-plugin AGENTS.md @ 46e14f2 -->

# Java style

## Formatting

- 4-space indent, no tabs, Allman braces, lines ≤180 columns (ADR 0001; checkstyle enforces all four).

## Injection

- Field `@Inject` for client services and config, as in `SolPlugin`.
- Guard `@Nullable` client-API returns before use.

## Logging

- Lombok `@Slf4j`; log through `log`, never `System.out`.
- Use `log.debug()` for developer/diagnostic logging.
- `log.info()` only for one-time startup/shutdown messages or infrequent events. RuneLite runs at INFO in production, so per-frame or per-event info logs pollute user logs.

## Cleanup

- Remove unused config classes, fields, and imports.
- Clean up subscriptions, listeners, and overlays in `shutDown()`.
