---
paths:
  - "src/main/**"
  - "runelite-plugin.properties"
  - "build.gradle"
  - "settings.gradle"
  - "LICENSE"
  - "icon.png"
---

<!-- Source: runelite/example-plugin AGENTS.md @ 46e14f2 -->

# Plugin Hub packaging

Hub CI treats every "fatal" below as a failed submission.

## Plugin Setup & Packaging

- Rename everything from the template: no `com.example`, `ExamplePlugin`, `ExampleConfig`, or `example` config group, in package path, class names, config group, `build.gradle` group, `settings.gradle` project name, or `runelite-plugin.properties`.
- No `META-INF/services/net.runelite.client.plugins.Plugin` file.
- No build artifacts in commits: no `.class` files, `out/`, or `.tmp` directories.
- `build.gradle` targets Java 11 and matches the template's structure. Sol's checkstyle and 4-space indent are deliberate deviations (ADR 0001).
- Keep a permissive license (Sol: BSD-2).

## `runelite-plugin.properties`

- Required: `displayName`, `author`, `description`, `plugins` (FQCNs extending `Plugin` with `@PluginDescriptor`), `build` (`standard` or `gradle`).
- Optional: `tags`, `version`, `support`.
- Any other key is fatal ("unknown key(s)").
- Gradle `version` and properties `version` stay equal and bump together.

## Build and jar

- `build=standard` compiles only `src/main/java`, `src/main/resources` and `lombok.config` against the client, Lombok and JetBrains annotations; our Gradle files, tests and checkstyle are local-only.
- No dependencies beyond the client (and its transitive deps) and Lombok; anything extra needs manual Hub hash review.
- No classes in `net.runelite.*` (fatal).
- Root `LICENSE`, exact name, no extension (fatal if missing).
- Jar ≤10 MiB; source zip ≤10 MiB.
- Terminally deprecated APIs are fatal, e.g. `new OkHttpClient()`, `new Gson()`, `WidgetInfo`/`WidgetID`.
- Load resources with `getResourceAsStream`, not `getResource` (the jar is not unpacked).

## Resources & Assets

- Optimize icon PNGs: Java holds images at `width × height × 4` bytes, so a small file can cost a lot of memory.
- PNGs must be real PNGs, never renamed JPEGs or ICOs.
- `icon.png` (optional, repo root): ≤256 KiB, 48x72 px.

## Forbidden Language Features

- All code must be Java 11 compatible
- No use of reflection
- No use of JNI or JNA
- No direct access to native memory access via Unsafe or LWJGL
- No executing external processes, including with Process or ProcessBuilder
- No downloading or dynamic loading of code, including classloading
- No runtime generation of code
- No use of Java (de)serialization
