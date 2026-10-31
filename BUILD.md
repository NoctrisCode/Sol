# Building Sol

## Requirements

- JDK 11 (Temurin).
- Gradle: none, the wrapper (`gradlew`) is included.
- IntelliJ IDEA: optional.

Commands below run from the repo root. (On Windows, use `gradlew.bat` in place of `./gradlew`.)

## Build

```sh
./gradlew build
```

Compiles, runs checkstyle and runs tests.

## Run a dev client

```sh
./gradlew run
```

Starts a RuneLite dev client with Sol loaded, flags `-ea --developer-mode --debug`.

IntelliJ: open the project, then click the green arrow on `SolPluginTest.main` (`src/test/java/net/lostlegion/sol/SolPluginTest.java`).

## Standalone jar

```sh
./gradlew shadowJar
java -ea -jar build/libs/*-all.jar --developer-mode
```

Builds a self-contained client+plugin jar and runs it.
