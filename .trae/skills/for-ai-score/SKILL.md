---
name: "for-ai-score"
description: "当用户说'查看 commit 信息'、'show commit'、'分析提交'时，输出指定 commit 的详细信息，包括作者、时间、变更文件和 diff 内容"
---

# 查看 Commit 信息

输出指定 git commit 的详细信息到项目根目录的 `for-ai-score-temp.md` 文件中，用于分析提交内容、审查代码变更或生成评分报告。

## How It Works

1. 用户提供 commit hash（完整或缩写均可），如未提供则默认使用 `HEAD`
2. 使用 `git show` 和 `git log` 获取 commit 的完整信息
3. 将结果写入项目根目录的 `for-ai-score-temp.md` 文件（若文件不存在则创建）

## Usage

当用户要求查看某个 commit 的信息时，按以下步骤执行：

### 步骤 1：收集 commit 信息

```bash
# 获取 commit 元数据（作者、日期、message）
git log -1 --format="Hash: %H%nAuthor: %an <%ae>%nDate: %ai%nSubject: %s%n%nBody:%n%b" <commit>

# 获取变更文件统计（排除 pnpm-lock.yaml）
git diff-tree --no-commit-id --stat -r <commit> -- . ':!**/pnpm-lock.yaml'

# 获取完整 diff 内容（排除任意位置的 pnpm-lock.yaml）
git show --stat --patch <commit> -- . ':!**/pnpm-lock.yaml'
```

### 步骤 2：写入文件

将收集到的信息按下方 Output 格式，使用 Write 工具写入项目根目录的 `for-ai-score-temp.md` 文件。若文件已存在则覆盖。

**参数：**

- `<commit>` - Commit hash 或引用（默认为 HEAD）

**示例：**

- 查看最新提交：使用 `HEAD`
- 查看指定提交：使用 `abc1234`
- 查看某分支最新提交：使用 `origin/main`

## Output

写入 `for-ai-score-temp.md` 的内容格式：

```markdown
# Commit 信息

## 元数据

- **Hash**: abc1234567890abcdef1234567890abcdef123456
- **Author**: July <july@example.com>
- **Date**: 2026-05-09 10:30:00 +0800
- **Subject**: feat: 添加用户登录功能

## Commit Message

实现了基于 JWT 的用户认证流程，包括登录、注册和 token 刷新。

## 变更文件

| 状态 | 文件路径 |
|------|----------|
| M | src/auth/login.ts |
| A | src/auth/register.ts |
| M | src/middleware.ts |

**统计**: 3 files changed, 45 insertions(+), 12 deletions(-)

## Diff

\```diff
（完整 diff 输出）
\```
```

## Present Results to User

- 写入文件后，告知用户信息已输出到 `for-ai-score-temp.md`
- 简要展示 commit 的 hash（前 7 位）、作者和 subject 作为确认
- 提示用户可以打开文件查看完整内容

## Troubleshooting

- commit 不存在 → 提示 hash 无效，建议用 `git log --oneline -10` 查看近期提交
- 不在 git 仓库中 → 提示当前目录不是 git 仓库
- shallow clone 导致历史不全 → 建议 `git fetch --unshallow`
