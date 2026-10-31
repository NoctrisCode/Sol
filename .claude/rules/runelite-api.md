---
paths:
  - "src/main/**/*.java"
---

<!-- Source: runelite/example-plugin AGENTS.md @ 46e14f2 -->

# RuneLite API

- Never block the client thread.
- Never `new` a client service: `@Inject` `OkHttpClient`, `Gson`, `ScheduledExecutorService` and the rest from the client.

## Threading & Concurrency

- Never use `Thread.sleep()`.
- Never block in `startUp()` or `shutDown()`: call `shutdownNow()` on executors, not `awaitTermination()`.
- Never do blocking network or disk IO on the client thread. Use the OkHttp thread pool for blocking network requests; to call back into `client` from it (e.g. a response queued with `enqueue()`), use `clientThread.invoke()`.
- Explicitly cancel scheduled tasks (e.g. `ScheduledFuture`) on shutdown, in addition to shutting down the executor.
- Batch async work with `CompletableFuture.allOf()`, not `CountDownLatch`.
- `Process.waitFor()`, if unavoidable, always takes a reasonable timeout.

## Performance

- Track what you care about from spawn/despawn events (objects, NPCs) in your own collection; avoid scanning the whole scene every tick or frame.
- Keep computation in Overlays, which run every frame, to a minimum.

## API Usage

- Use `net.runelite.api.gameval` constants (`ItemID`, `InterfaceID`, `ObjectID`, ...) instead of magic numbers.
- Open URLs with `LinkBrowser`, not `java.awt.Desktop`.
- Look up widgets by gameval component ID (e.g. `client.getWidget(InterfaceID.DomEndLevelUi.LOOT_VALUE)`), never by combining interface + child IDs by hand.
- Java reflection is forbidden.

## HTTP & JSON

- All HTTP goes through OkHttp via `@Inject OkHttpClient`. Not `HttpURLConnection`, `java.net.http.HttpClient`, or Apache HttpClient.
- Get Gson via `@Inject Gson`; derive variants with `.newBuilder()`.
- Keep `runelite-client` transitive deps (gson, guice, okhttp) out of `build.gradle`.
- OkHttp calls run off the client thread: prefer `enqueue()`, which uses the OkHttp thread pool.

## File I/O

- All file I/O goes through the `Filepath` utility, which requires `@PluginDescriptor(internalName = ...)`.
- Use `Filepath.Chooser`, not `JFileChooser`.
- To migrate a legacy data folder from `.runelite`, set `@PluginDescriptor(legacyDataDirectory = ...)`.
