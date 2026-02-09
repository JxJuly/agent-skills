---
name: "git-commit"
description: "自动执行 git add 和 commit，并基于代码变更生成描述性的 commit message。当用户想要快速提交代码变更时调用。"
---

# 自动 Git Commit

这个 skill 帮助你自动化 git add 和 git commit 流程，无需手动编写 commit message。

## 功能特性

1. **自动 Stage 所有变更**: 执行 `git add .` 添加所有修改、新增和删除的文件
2. **智能生成 Commit Message**: 基于 `git diff` 分析代码变更，自动生成描述性的 commit message
3. **一键提交**: 自动完成整个 commit 流程

## 使用场景

当用户说：
- "提交代码"
- "commit 这些改动"
- "git commit"
- "自动提交"
- "保存这些修改"
- 或任何表示想要提交代码的意图时

## 工作流程

1. **检查状态**: 
   - 运行 `git status` 查看当前变更
   - 如果没有变更，提示用户并退出

2. **查看变更详情**:
   - 运行 `git diff --staged` (如果有已 stage 的文件)
   - 运行 `git diff` (查看未 stage 的文件变更)
   - 获取文件列表和变更统计

3. **自动 Stage**:
   - 执行 `git add .` 添加所有变更

4. **分析并生成 Commit Message**:
   - 基于 diff 内容，分析代码变更
   - 生成清晰、描述性的 commit message
   - Commit message 应该：
     - 使用简洁的中文描述（如果代码库主要是中文项目）
     - 遵循常见的 commit 规范（如 feat:, fix:, refactor:, chore: 等）
     - 准确反映主要变更内容
     - 如果有多个不相关的变更，在 message body 中分点说明

5. **执行 Commit**:
   - 使用生成的 message 执行 `git commit -m "message"`
   - 显示 commit 结果和 commit hash

6. **确认完成**:
   - 显示 commit 成功信息
   - 提示用户可以使用 `git push` 推送到远程仓库

## Commit Message 格式规范

遵循 Conventional Commits 格式：

```
<type>: <subject>

[optional body]
```

### Type 类型：
- `feat`: 新功能
- `fix`: 修复 bug
- `refactor`: 重构代码
- `style`: 代码格式调整（不影响功能）
- `docs`: 文档更新
- `test`: 测试相关
- `chore`: 构建工具、依赖等杂项
- `perf`: 性能优化

### 示例：

简单变更：
```
feat: 添加用户登录功能
```

复杂变更：
```
feat: 实现用户认证系统

- 添加登录和注册页面
- 实现 JWT token 认证
- 添加密码加密功能
```

## 注意事项

1. **运行前检查**: 
   - 确保在 git 仓库中运行
   - 确保有未提交的变更

2. **生成的 Message 建议**:
   - 显示给用户查看生成的 commit message
   - 询问用户是否接受，或是否需要修改

3. **安全考虑**:
   - 不要 commit 敏感信息（密钥、密码等）
   - 检查 diff 中是否包含不应提交的内容

4. **最佳实践**:
   - 鼓励原子性提交（每次 commit 只关注一个功能或修复）
   - 如果变更过多过杂，建议用户分多次提交

## 实现步骤

执行此 skill 时，按以下步骤操作：

1. 运行 `git status --short` 检查是否有变更
2. 如果有变更，运行 `git diff HEAD` 获取完整的变更内容
3. 分析 diff 输出，理解代码变更的性质和范围
4. 生成符合规范的 commit message
5. 显示 message 并询问用户确认
6. 执行 `git add .`
7. 执行 `git commit -m "<generated-message>"`
8. 显示成功信息和后续建议

## 错误处理

- **没有变更**: 提示用户当前没有需要提交的变更
- **不在 git 仓库**: 提示用户当前目录不是 git 仓库
- **Commit 失败**: 显示错误信息，建议用户检查问题
- **有冲突文件**: 提示用户先解决冲突再提交
