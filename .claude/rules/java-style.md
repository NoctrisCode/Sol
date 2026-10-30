---
paths:
  - "src/**/*.java"
---

# Java style (RuneLite)

- 4-space indent, no tabs. Lombok `@Slf4j` for logging; no `System.out`.
- Prefer `final` fields and constructor injection.
- No work on the client thread beyond O(ticks); offload to `ScheduledExecutorService`.
- Null-safety: annotate client-API returns as `@Nullable` where the API does; guard before use.
