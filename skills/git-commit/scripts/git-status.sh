#!/bin/bash
set -e

cleanup() {
  rm -f "$TEMP_FILE"
}
trap cleanup EXIT

if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
  echo '{"error": "not_a_git_repo", "message": "当前目录不是 git 仓库"}' 
  exit 1
fi

TEMP_FILE=$(mktemp)

HAS_STAGED=$(git diff --cached --quiet 2>/dev/null && echo "false" || echo "true")
HAS_UNSTAGED=$(git diff --quiet 2>/dev/null && echo "false" || echo "true")
UNTRACKED_COUNT=$(git ls-files --others --exclude-standard | wc -l | tr -d ' ')

if [ "$HAS_STAGED" = "false" ] && [ "$HAS_UNSTAGED" = "false" ] && [ "$UNTRACKED_COUNT" = "0" ]; then
  echo '{"error": "no_changes", "message": "没有需要提交的变更"}'
  exit 0
fi

BRANCH=$(git branch --show-current 2>/dev/null || echo "HEAD")
REMOTE=$(git remote 2>/dev/null | head -1 || echo "")
HAS_CONFLICTS=$(git ls-files --unmerged | wc -l | tr -d ' ')

if [ "$HAS_CONFLICTS" != "0" ]; then
  CONFLICT_FILES=$(git ls-files --unmerged | awk '{print $4}' | sort -u | head -20)
  echo "{\"error\": \"has_conflicts\", \"message\": \"存在未解决的冲突文件\", \"conflict_files\": \"$CONFLICT_FILES\"}"
  exit 1
fi

echo "收集变更信息..." >&2

STATUS=$(git status --porcelain)
STAGED_DIFF=""
UNSTAGED_DIFF=""
STAT=""

if [ "$HAS_STAGED" = "true" ]; then
  STAGED_DIFF=$(git diff --cached --stat)
  echo "已暂存的变更:" >&2
  echo "$STAGED_DIFF" >&2
fi

if [ "$HAS_UNSTAGED" = "true" ] || [ "$UNTRACKED_COUNT" != "0" ]; then
  UNSTAGED_DIFF=$(git diff --stat)
  STAT=$(git diff --shortstat)
  echo "未暂存的变更:" >&2
  echo "$UNSTAGED_DIFF" >&2
fi

DIFF_CONTENT=""
if [ "$HAS_STAGED" = "true" ]; then
  DIFF_CONTENT=$(git diff --cached)
else
  DIFF_CONTENT=$(git diff)
fi

UNTRACKED_FILES=""
if [ "$UNTRACKED_COUNT" != "0" ]; then
  UNTRACKED_FILES=$(git ls-files --others --exclude-standard | head -30)
fi

cat > "$TEMP_FILE" << JSONEOF
{
  "branch": "$BRANCH",
  "remote": "$REMOTE",
  "has_staged": $HAS_STAGED,
  "has_unstaged": $HAS_UNSTAGED,
  "untracked_count": $UNTRACKED_COUNT,
  "status": $(echo "$STATUS" | python3 -c "import sys,json; print(json.dumps(sys.stdin.read()))" 2>/dev/null || echo "\"$STATUS\""),
  "staged_diff_stat": $(echo "$STAGED_DIFF" | python3 -c "import sys,json; print(json.dumps(sys.stdin.read()))" 2>/dev/null || echo "\"\""),
  "unstaged_diff_stat": $(echo "$UNSTAGED_DIFF" | python3 -c "import sys,json; print(json.dumps(sys.stdin.read()))" 2>/dev/null || echo "\"\""),
  "diff_content": $(echo "$DIFF_CONTENT" | head -500 | python3 -c "import sys,json; print(json.dumps(sys.stdin.read()))" 2>/dev/null || echo "\"(diff too large to encode)\""),
  "untracked_files": $(echo "$UNTRACKED_FILES" | python3 -c "import sys,json; print(json.dumps(sys.stdin.read()))" 2>/dev/null || echo "\"\""),
  "shortstat": $(echo "$STAT" | python3 -c "import sys,json; print(json.dumps(sys.stdin.read().strip()))" 2>/dev/null || echo "\"\"")
}
JSONEOF

cat "$TEMP_FILE"
