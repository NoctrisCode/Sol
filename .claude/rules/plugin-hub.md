---
paths:
  - "src/**/*.java"
  - "runelite-plugin.properties"
---

# Plugin Hub submission constraints

- `runelite-plugin.properties` must set `displayName`, `author`, `description`, `tags`.
- No bundled dependencies outside the allowlist; shade nothing unapproved.
- Never dispatch mouse/keyboard input. Flag any `Robot`, `MouseManager` input, or `KeyManager` typing as a blocker.
- No external network calls except through RuneLite-approved APIs.
- No reflection into client internals, no reading other plugins' state.