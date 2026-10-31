---
paths:
  - "src/**/*Config.java"
---

<!-- Source: runelite/example-plugin AGENTS.md @ 46e14f2 -->

# Config

## Group naming

Single source for config group names; the `new-plugin-config` skill defers here.

- Declare the group as a constant and reference it: `String GROUP = "lostlegion<lowername>";` inside the interface, annotated `@ConfigGroup(<Name>Config.GROUP)`. `<lowername>` is the config name lowercased, e.g. `SolConfig` → `"lostlegionsol"`.
- Group names must be specific: `"lostlegiondeadmanprices"`, not `"lostlegiondeadman"`. The `lostlegion` prefix keeps Sol's groups clear of other plugins.

## Changing config

- Never rename a config key or group without a migration. Renaming silently resets users' saved settings.

## Third-party servers

A `@ConfigItem` that toggles a feature contacting a third-party server must:

- be **disabled by default** (opt-in);
- set `warning` to `"This feature submits your IP address to a 3rd-party server not controlled or verified by RuneLite developers"`.
