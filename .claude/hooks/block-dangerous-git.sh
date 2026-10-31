#!/bin/bash

INPUT=$(cat)

# Extract a top-level string field; jq if present, else grep fallback.
json_field() {
    if command -v jq >/dev/null 2>&1; then
        echo "$INPUT" | jq -r ".$1 // empty"
    else
        echo "$INPUT" | grep -oE "\"$2\"[[:space:]]*:[[:space:]]*\"([^\"\\\\]|\\\\.)*\"" \
            | head -n1 \
            | sed -E "s/^\"$2\"[[:space:]]*:[[:space:]]*\"//; s/\"$//" \
            | sed -E 's/\\"/"/g; s/\\\\/\\/g'
    fi
}

COMMAND=$(json_field tool_input.command command)
CWD=$(json_field cwd cwd)
CWD=${CWD:-$CLAUDE_PROJECT_DIR}

PROTECTED_BRANCHES=(master develop)

DANGEROUS_PATTERNS=(
    "git reset --hard"
    "git clean -fd"
    "git clean -f"
    "git branch -D"
    "git checkout \."
    "git restore \."
    "push --force"
    "push -f"
    "push --mirror"
    "push --all"
    "reset --hard"
)

block() {
    echo "BLOCKED: '$COMMAND' $1. The user has prevented you from doing this." >&2
    exit 2
}

is_protected() {
    local branch
    for branch in "${PROTECTED_BRANCHES[@]}"; do
        [[ "$1" == "$branch" ]] && return 0
    done
    return 1
}

current_branch() {
    git -C "$CWD" rev-parse --abbrev-ref HEAD 2>/dev/null
}

# Refspec "[+]src[:dst]" -> destination branch name.
refspec_target() {
    local spec=${1#+}
    local dst=${spec##*:}
    dst=${dst#refs/heads/}
    [[ "$dst" == "HEAD" ]] && dst=$(current_branch)
    echo "$dst"
}

# Positional args of each `git push` segment, flags dropped.
push_args() {
    echo "$COMMAND" | grep -oE 'git push[^;&|]*' | sed -E 's/^git push//'
}

check_push_segment() {
    local args=()
    local word
    for word in $1; do
        [[ "$word" == -* ]] || args+=("$word")
    done
    local targets=("${args[@]:1}")
    [[ ${#targets[@]} -eq 0 ]] && targets=("$(current_branch)")
    local target
    for target in "${targets[@]}"; do
        is_protected "$(refspec_target "$target")" && block "pushes to protected branch '$(refspec_target "$target")'"
    done
}

for pattern in "${DANGEROUS_PATTERNS[@]}"; do
    echo "$COMMAND" | grep -qE "$pattern" && block "matches dangerous pattern '$pattern'"
done

while IFS= read -r segment; do
    check_push_segment "$segment"
done < <(push_args)

exit 0
