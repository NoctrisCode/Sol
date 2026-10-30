#!/bin/bash

INPUT=$(cat)

# Extract .tool_input.file_path; jq if present, else grep fallback.
if command -v jq >/dev/null 2>&1; then
    FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')
else
    FILE=$(echo "$INPUT" | grep -oE '"file_path"[[:space:]]*:[[:space:]]*"([^"\\]|\\.)*"' \
        | head -n1 \
        | sed -E 's/^"file_path"[[:space:]]*:[[:space:]]*"//; s/"$//')
fi

[[ "$FILE" == *.java ]] || exit 0

TASK=checkstyleMain
[[ "$FILE" =~ [/\\]src[/\\]+test[/\\] ]] && TASK=checkstyleTest

cd "$CLAUDE_PROJECT_DIR" || exit 0
[[ -x ./gradlew ]] || exit 0

# Exit 2 feeds violations back to Claude; trimmed to keep context small.
if ! OUT=$(./gradlew "$TASK" --quiet 2>&1); then
    echo "$OUT" | tail -n 30 >&2
    exit 2
fi

exit 0
