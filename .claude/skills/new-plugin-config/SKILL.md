---
name: new-plugin-config
description: Scaffold a RuneLite @ConfigGroup interface with typed @ConfigItem entries wired to the plugin.
argument-hint: "<ConfigName>"
allowed-tools: Read, Write, Edit, Grep
model: opus
metadata:
  domain: runelite
---

# New plugin config

Read `.claude/rules/config.md` first: it owns the config group name and the third-party-server rules.

Given a config name argument, generate `src/main/java/.../<Name>Config.java`:

1. Interface extends `net.runelite.client.config.Config`, with the group constant and `@ConfigGroup` exactly as `config.md` specifies.
2. One `@ConfigItem` per requested option, with `keyName`, `name`, `description`, `position`.
3. Use `default` methods returning the typed value (`boolean`, `Color`, `int`, enum).
4. Inject into the plugin via `@Provides` on a method returning the interface from `ConfigManager`.

Match the package of the existing `*Plugin.java`.
