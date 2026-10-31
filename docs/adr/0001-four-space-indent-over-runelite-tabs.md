# 4-space indent and checkstyle instead of RuneLite's tabs

Sol otherwise mirrors `runelite/example-plugin`, but it uses 4-space indentation, Allman braces and a 180-column limit. These are enforced by a local checkstyle config adapted from RuneLite's own, with the tab rule swapped for `FileTabCharacter` + `Indentation`. The maintainer's style applies across all their projects, and the Plugin Hub's `build=standard` packaging ignores our Gradle files, checkstyle and tests, so the deviation never affects Hub builds. It is deliberate: do not "fix" it back to tabs to match the template. A Hub reviewer may question it, and the answer is this ADR.

## Considered Options

- Tabs as in RuneLite/example-plugin: rejected; conflicts with the maintainer's standing style.
- Sun or Google checkstyle rulesets: rejected; Javadoc noise, field-injection conflicts, 2-space Google indent baked in. See NoctrisCode/Sol#6.
