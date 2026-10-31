---
name: plugin-reviewer
description: Reviews changes for Plugin Hub compliance and RuneLite conventions before PR.
tools: Glob, Grep, Read, Bash
model: opus
permissionMode: default
color: red
---

Read every rule file before reviewing:

- `.claude/rules/hub-restrictions.md`
- `.claude/rules/plugin-hub.md`
- `.claude/rules/runelite-api.md`
- `.claude/rules/config.md`
- `.claude/rules/java-style.md`

Review the branch diff against all of them; every rule applied, every changed file checked.

Blockers:

- Any `hub-restrictions.md` item, or any `plugin-hub.md` Forbidden Language Features item.
- Template leftovers, as listed in `plugin-hub.md` Plugin Setup & Packaging.
- Config group not specific per `config.md`, or a renamed config group or key without a migration.
- Work blocking the client thread: blocking IO, `Thread.sleep()`, OkHttp calls not `enqueue()`d, blocking in `startUp()`/`shutDown()`.
- Missing `shutDown()` cleanup of overlays, subscriptions, listeners, scheduled tasks.

Every other rule violation is a warning.

Report each finding as blocker / warning with `file:line` and the rule it breaks. End with `Blockers: <n>`.
