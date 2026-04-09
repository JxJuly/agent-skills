#!/bin/bash
set -e

TEMP_FILE=""
cleanup() {
  [ -n "$TEMP_FILE" ] && rm -f "$TEMP_FILE"
}
trap cleanup EXIT

PKG_PATH=""
APPLY=false

for arg in "$@"; do
  case "$arg" in
    --apply) APPLY=true ;;
    *) PKG_PATH="$arg" ;;
  esac
done

if [ -z "$PKG_PATH" ]; then
  PKG_PATH="./package.json"
fi

if [ ! -f "$PKG_PATH" ]; then
  echo "{\"error\": \"file_not_found\", \"message\": \"文件不存在: $PKG_PATH\"}"
  exit 1
fi

if ! python3 -c "import json; json.load(open('$PKG_PATH'))" 2>/dev/null; then
  echo "{\"error\": \"invalid_json\", \"message\": \"JSON 解析失败，请先手动修复语法错误: $PKG_PATH\"}"
  exit 1
fi

echo "分析 $PKG_PATH ..." >&2

TEMP_FILE=$(mktemp)

python3 << 'PYEOF' - "$PKG_PATH" "$APPLY" "$TEMP_FILE"
import json
import sys
import os

pkg_path = sys.argv[1]
apply_mode = sys.argv[2].lower() == "true"
temp_file = sys.argv[3]

STANDARD_FIELDS_ORDER = [
    # === Metadata: 你是谁 ===
    "name",
    "version",
    "description",
    "keywords",
    "license",
    "author",
    "contributors",
    "repository",
    "homepage",
    "bugs",
    "funding",
    # === Environment: 在哪运行 ===
    "private",
    "type",
    "packageManager",
    "engines",
    "devEngines",
    "os",
    "cpu",
    # === Entries: 入口在哪 ===
    "main",
    "module",
    "browser",
    "types",
    "typings",
    "exports",
    "imports",
    "bin",
    "man",
    "directories",
    "files",
    "sideEffects",
    # === Scripts: 怎么构建 ===
    "scripts",
    "config",
    # === Dependencies: 依赖了谁 ===
    "dependencies",
    "devDependencies",
    "peerDependencies",
    "peerDependenciesMeta",
    "optionalDependencies",
    "bundleDependencies",
    "bundledDependencies",
    "overrides",
    "resolutions",
    # === Publish: 怎么发布 ===
    "publishConfig",
    "workspaces",
]

STANDARD_FIELDS_SET = set(STANDARD_FIELDS_ORDER)

dir_name = os.path.basename(os.path.dirname(os.path.abspath(pkg_path)))

REQUIRED_DEFAULTS = {
    "name": dir_name,
    "version": "0.0.0",
    "description": "",
    "keywords": [],
    "license": "MIT",
    "author": "",
    "scripts": {},
}

with open(pkg_path, "r", encoding="utf-8") as f:
    original = json.load(f)

original_keys = list(original.keys())

non_standard = [k for k in original_keys if k not in STANDARD_FIELDS_SET]

added = []
for field, default in REQUIRED_DEFAULTS.items():
    if field not in original:
        added.append(field)

current_standard_order = [k for k in original_keys if k in STANDARD_FIELDS_SET]
target_standard_order = [k for k in STANDARD_FIELDS_ORDER if k in original or k in [a for a in added]]

reordered = current_standard_order != [k for k in target_standard_order if k in current_standard_order]

reordered_fields = target_standard_order if reordered else []

has_changes = bool(non_standard) or bool(added) or reordered

if apply_mode and has_changes:
    result = {}
    for field in STANDARD_FIELDS_ORDER:
        if field in original:
            result[field] = original[field]
        elif field in REQUIRED_DEFAULTS and field not in original:
            result[field] = REQUIRED_DEFAULTS[field]

    with open(pkg_path, "w", encoding="utf-8") as f:
        json.dump(result, f, indent=2, ensure_ascii=False)
        f.write("\n")

    report = {
        "file": pkg_path,
        "reordered_fields": reordered_fields,
        "added_fields": added,
        "removed_fields": non_standard,
        "applied": True,
    }
else:
    report = {
        "file": pkg_path,
        "reordered_fields": reordered_fields,
        "added_fields": added,
        "removed_fields": non_standard,
        "has_changes": has_changes,
    }

with open(temp_file, "w", encoding="utf-8") as f:
    json.dump(report, f, indent=2, ensure_ascii=False)
PYEOF

cat "$TEMP_FILE"
