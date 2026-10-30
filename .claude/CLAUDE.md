A RuneLite Plugin Hub plugin. Java 11, Gradle, built against the RuneLite client API.

## Build & run

- `./gradlew build` — compile + checkstyle + tests. Must pass before any commit.
- `./gradlew shadowJar` — standalone jar for manual client loading.
- Run in-client: launch RuneLite from the IntelliJ `Plugin` run config (external plugin dir points at `build/classes`).

## Conventions

- Never block the client thread.
- Never `new` a client service.

## Agent skills

### Issue tracker

Issues are tracked as GitHub issues on `NoctrisCode/Sol` via the `gh` CLI. See `docs/agents/issue-tracker.md`.

### Triage labels

Default canonical labels: `needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`. See `docs/agents/triage-labels.md`.

### Domain docs

Single-context: `GLOSSARY.md` + `docs/adr/` at the repo root. See `docs/agents/domain.md`.
