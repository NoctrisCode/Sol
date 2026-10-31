A RuneLite Plugin Hub plugin. Java 11, Gradle, built against the RuneLite client API.

## Build & run

- `./gradlew build` — compile + checkstyle + tests. Must pass before any commit.
- `./gradlew run` — dev client with Sol loaded via `loadBuiltin`, flags `-ea --developer-mode --debug`. IntelliJ: green arrow on `SolPluginTest.main`.
- `./gradlew shadowJar` — self-contained client+plugin jar; run with `java -ea -jar build/libs/*-all.jar --developer-mode`.

## Testing protocol

Only the user can verify Sol in-game. Never drive RuneScape with screen-capture or computer-use tools: automating game input breaks Jagex's third-party client guidelines and gets the account banned.

After a change, the task stays open until the user confirms it in-game:

1. Offer to run `./gradlew run` from the repo root.
2. Point the user to https://github.com/runelite/runelite/wiki/Using-Jagex-Accounts to log in to the dev client.
3. Tell the user what to test: the changed behaviour, the golden path, edge cases worth exercising.
4. Wait for the user to confirm it works in-game. A green build or clean JVM start is not a pass.

## Commit hygiene

Commits carry source only, no build artifacts; reformatting goes in its own commit, never mixed with feature changes.

## Agent skills

### Issue tracker

Issues are tracked as GitHub issues on `NoctrisCode/Sol` via the `gh` CLI. See `docs/agents/issue-tracker.md`.

### Triage labels

Default canonical labels: `needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`. See `docs/agents/triage-labels.md`.

### Domain docs

Single-context: `GLOSSARY.md` + `docs/adr/` at the repo root. See `docs/agents/domain.md`.
