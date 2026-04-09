---
name: "package-json-fix"
description: "当用户说'修复 package.json'、'整理 package.json'、'fix package.json'时，自动优化字段顺序、补全标准字段、删除非标准字段"
---

# 修复 Package.json

自动化修复 package.json 文件：优化字段顺序、补全缺失的标准字段、删除非标准字段。

## 流程

1. 运行脚本分析当前 package.json：`bash ./scripts/fix.sh [path]`（输出 JSON 分析报告）
2. 根据分析结果，向用户展示将要进行的变更
3. 用户确认后，运行修复：`bash ./scripts/fix.sh [path] --apply`
4. 展示修复结果

## Usage

```bash
# 分析（仅报告，不修改文件）
bash ./scripts/fix.sh [path/to/package.json]

# 应用修复
bash ./scripts/fix.sh [path/to/package.json] --apply
```

**Arguments:**

- `path` - package.json 文件路径（默认为当前目录下的 `./package.json`）
- `--apply` - 实际执行修复并写入文件（不加此参数时仅输出分析报告）

**Examples:**

```bash
# 分析当前目录的 package.json
bash ./scripts/fix.sh

# 分析指定路径
bash ./scripts/fix.sh /path/to/project/package.json

# 应用修复
bash ./scripts/fix.sh ./package.json --apply
```

## 标准字段与排序

排序逻辑：**你是谁 → 在哪运行 → 入口在哪 → 怎么构建 → 依赖了谁 → 怎么发布**

标注 ★ 的为必需字段，缺失时自动补全默认值；其余字段仅在已存在时保留并排序。

### Metadata（你是谁）

| 字段 | 默认值 | 来源 |
|------|--------|------|
| `name` ★ | 从目录名推断 | npm |
| `version` ★ | `"0.0.0"` | npm |
| `description` ★ | `""` | npm |
| `keywords` ★ | `[]` | npm |
| `license` ★ | `"MIT"` | npm |
| `author` ★ | `""` | npm |
| `contributors` | — | npm |
| `repository` | — | npm |
| `homepage` | — | npm |
| `bugs` | — | npm |
| `funding` | — | npm |

### Environment（在哪运行）

| 字段 | 默认值 | 来源 |
|------|--------|------|
| `private` | — | npm |
| `type` | — | Node.js |
| `packageManager` | — | Corepack |
| `engines` | — | npm |
| `devEngines` | — | npm |
| `os` | — | npm |
| `cpu` | — | npm |

### Entries（入口在哪）

| 字段 | 默认值 | 来源 |
|------|--------|------|
| `main` | — | npm |
| `module` | — | 社区 |
| `browser` | — | npm |
| `types` | — | TypeScript |
| `typings` | — | TypeScript (旧) |
| `exports` | — | Node.js |
| `imports` | — | Node.js |
| `bin` | — | npm |
| `man` | — | npm |
| `directories` | — | npm |
| `files` | — | npm |
| `sideEffects` | — | Webpack |

### Scripts（怎么构建）

| 字段 | 默认值 | 来源 |
|------|--------|------|
| `scripts` ★ | `{}` | npm |
| `config` | — | npm |

### Dependencies（依赖了谁）

| 字段 | 默认值 | 来源 |
|------|--------|------|
| `dependencies` | — | npm |
| `devDependencies` | — | npm |
| `peerDependencies` | — | npm |
| `peerDependenciesMeta` | — | npm |
| `optionalDependencies` | — | npm |
| `bundleDependencies` | — | npm |
| `bundledDependencies` | — | npm (别名) |
| `overrides` | — | npm |
| `resolutions` | — | Yarn |

### Publish（怎么发布）

| 字段 | 默认值 | 来源 |
|------|--------|------|
| `publishConfig` | — | npm |
| `workspaces` | — | npm |

不在上述列表中的字段视为**非标准字段**，将被删除。

## Output

分析模式输出示例：

```json
{
  "file": "./package.json",
  "reordered_fields": ["version", "name", "description"],
  "added_fields": ["keywords", "license"],
  "removed_fields": ["custom-field", "x-internal"],
  "has_changes": true
}
```

应用模式输出示例：

```json
{
  "file": "./package.json",
  "reordered_fields": ["version", "name", "description"],
  "added_fields": ["keywords", "license"],
  "removed_fields": ["custom-field", "x-internal"],
  "applied": true
}
```

## Present Results to User

分析模式：

```
📋 Package.json 分析报告
   文件: ./package.json

   🔄 字段重排: name, version, description, ...
   ➕ 补全字段: keywords, license
   ❌ 移除字段: custom-field, x-internal

确认应用这些变更吗？
```

应用模式：

```
✅ Package.json 修复完成
   文件: ./package.json
   🔄 重排了 N 个字段
   ➕ 补全了 N 个字段
   ❌ 移除了 N 个字段
```

## Troubleshooting

- 文件不存在 → 提示指定正确的 package.json 路径
- JSON 解析失败 → 提示 package.json 格式错误，需手动修复语法
- 无写入权限 → 提示检查文件权限
