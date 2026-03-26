---
name: "git-commit"
description: "当用户说'提交代码'、'commit'、'push'时，自动分析变更并生成语义化 commit message"
---

# 自动 Git Commit

自动化 git add、commit、push 流程。

## 流程

1. 运行脚本收集信息：`bash /mnt/skills/user/git-commit/scripts/git-status.sh`（输出 JSON，含 branch/remote/status/diff_content。有 `error` 字段时按 Troubleshooting 处理）
2. 分析 diff_content，判断变更类型和范围
3. **新分支（可选）**：默认跳过。仅当①用户要求，或②在 main/master 上且变更大（>5 文件或跨多模块）时，建议切分支（如 `feat/create-new-skill`），确认后执行 `git checkout -b`
4. **安全检查**：stage 前扫描文件列表和 diff 内容，发现敏感文件或密钥则**停止并询问用户**
   - 敏感文件：`.env*`、`*.pem`、`*.key`、`id_rsa*`、`*.p12`、`*.pfx`、文件名含 `secret/credential/password/token`
   - 敏感内容：`AKIA`、`sk-`、`-----BEGIN`
5. **原子性检查**：满足任一条件时建议拆分提交：涉及 >2 种 type、分布 >3 个不相关目录、>10 文件无单一目的。拆分时用 `git add <文件>` 代替 `git add .`
6. 执行 `git add .` + `git commit -m "<message>"`
7. **Push（可选）**：默认不 push。仅当用户明确要求 push，或 remote 非空时询问用户。未 push 时提示可手动 `git push`

## Commit Message 规范

格式：`<type>: <subject>\n\n[body]`，遵循 Conventional Commits。type 从 feat/fix/refactor/style/docs/test/chore/perf 中选，不确定用 chore。type 始终英文。

语言优先级：用户指定 > `git log --oneline -5` 多数语言 > 对话语言 > 英文。

## 输出

```
✅ 提交成功
   分支: main | Commit: abc1234
   Message: feat: 添加用户登录功能
   变更: 3 files changed, 45(+), 12(-)
```

push 后追加：`✅ 已推送到远程仓库 origin/main`。未 push 则提示 `git push`。

## Troubleshooting

- 无变更 → 提示无需提交
- 非 git 仓库 → 提示不在仓库中
- 有冲突 → 提示先解决冲突
- 无远程仓库 → 提示 `git remote add origin <url>`
- commit/push 失败 → 显示错误信息
