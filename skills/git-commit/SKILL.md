---
name: git-commit
description: 当用户说“提交代码”、“commit”、“push”时，检查 Git 变更，生成语义化 commit message，并按需提交或推送。
---

# 自动 Git Commit

帮助用户完成安全、清晰的 Git 提交。优先保持提交原子、信息准确；除非用户明确要求，不自动 push。

## How It Works

1. 收集状态：运行 `git status --short --branch`，再按需要查看 `git diff --stat`、`git diff`、`git diff --cached --stat`、`git diff --cached`、`git ls-files --others --exclude-standard`。
2. 处理阻塞情况：非 Git 仓库、无变更、存在冲突、commit 或 push 失败时，按 Troubleshooting 反馈。
3. 安全检查：stage 前检查文件名和 diff 内容。发现疑似敏感文件或密钥时停止并询问用户。
4. 原子性检查：如果变更明显包含多个目的，建议拆分提交；拆分时只 stage 对应文件。
5. 生成 commit message：分析 diff，选择 Conventional Commits 类型和简洁 subject；必要时补充 body。
6. 提交：执行 `git add <files>` 或 `git add .`，再执行 `git commit -m "<message>"`。不要提交与用户请求无关的已有变更。
7. Push：只有用户明确要求 push 时才执行。没有要求时，提交成功后提示可运行的 `git push` 命令。

## Checks

**Sensitive files:** `.env*`, `*.pem`, `*.key`, `id_rsa*`, `*.p12`, `*.pfx`, or paths containing `secret`, `credential`, `password`, `token`.

**Sensitive content:** obvious keys or tokens such as `AKIA`, `sk-`, `-----BEGIN`, `PRIVATE KEY`, `access_token`, `api_key`.

Suggest splitting commits when changes include more than 2 unrelated purposes, span more than 3 unrelated directories, or touch more than 10 files without one clear intent.

## Commit Message

Use Conventional Commits:

```text
<type>: <subject>

[body]
```

Types: `feat`, `fix`, `refactor`, `style`, `docs`, `test`, `chore`, `perf`. Use `chore` when uncertain.

Language priority: user request > majority language in `git log --oneline -5` > conversation language > English. The type is always English.

## Present Results to User

```
提交成功
分支: main
Commit: abc1234
Message: feat: 添加用户登录功能
变更: 3 files changed, 45 insertions(+), 12 deletions(-)
```

Push 后追加：`已推送到 origin/main`。未 push 时给出下一步命令，例如 `git push -u origin <branch>`。

## Troubleshooting

- 无变更：提示无需提交。
- 非 Git 仓库：提示当前目录不在 Git 仓库中。
- 有冲突：列出冲突文件，提示先解决冲突。
- 检测到敏感内容：停止提交，说明命中的文件或片段类型。
- 无远程仓库：提交可完成；push 前提示 `git remote add origin <url>`。
- commit 或 push 失败：展示关键错误信息，并说明下一步。
