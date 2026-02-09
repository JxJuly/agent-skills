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

1. **判断用户意图（Push 需求）**:
   - **第一步就判断**：从用户最初的输入推测是否需要 push
     - 明确要 push："提交并推送"、"commit 并 push"、"提交代码到远程"、"保存并上传"
     - 明确不要 push："只 commit"、"仅提交到本地"、"先不推送"、"不要 push"
     - 不明确："提交代码"、"commit"、"自动提交"、"保存修改"
   - **如果无法推测用户意图**，立即使用 AskUserQuestion 工具询问用户（在执行任何 git 操作前完成信息收集）

2. **检查状态**: 
   - 运行 `git status` 查看当前变更
   - 如果没有变更，提示用户并退出

3. **查看变更详情**:
   - 运行 `git diff --staged` (如果有已 stage 的文件)
   - 运行 `git diff` (查看未 stage 的文件变更)
   - 获取文件列表和变更统计

4. **自动 Stage**:
   - 执行 `git add .` 添加所有变更

5. **分析并生成 Commit Message**:
   - 基于 diff 内容，分析代码变更
   - 生成清晰、描述性的 commit message
   - Commit message 应该：
     - 使用简洁的中文描述（如果代码库主要是中文项目）
     - 遵循常见的 commit 规范（如 feat:, fix:, refactor:, chore: 等）
     - 准确反映主要变更内容
     - 如果有多个不相关的变更，在 message body 中分点说明

6. **执行 Commit**:
   - 使用生成的 message 执行 `git commit -m "message"`
   - 显示 commit 结果和 commit hash

7. **可选 Push**:
   - 如果用户确认需要 push：
     - 检查是否有远程仓库配置
     - 执行 `git push` 推送到远程仓库
     - 显示 push 结果
   - 如果用户不需要 push：
     - 提示用户稍后可以手动执行 `git push`

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

2. **安全考虑**:
   - 不要 commit 敏感信息（密钥、密码等）
   - 检查 diff 中是否包含不应提交的内容

3. **最佳实践**:
   - 鼓励原子性提交（每次 commit 只关注一个功能或修复）
   - 如果变更过多过杂，建议用户分多次提交

4. **交互方式**:
   - **在第一步就收集所有需要的用户输入**，类似 skill-creator 的模式
   - 如果无法从用户输入推测是否需要 push，在执行任何 git 操作前就使用 AskUserQuestion 工具询问
   - 不要中断 agent 流程等待用户在终端输入
   - 不需要在执行前展示 commit message 让用户确认，直接执行即可
   - 一旦收集完所有信息，就可以连续执行所有 git 操作，无需中途再询问

## 实现步骤

执行此 skill 时，按以下步骤操作：

### 第一阶段：信息收集（在任何 git 操作前完成）

1. **判断用户意图（是否需要 push）**：
   - 分析用户最初的输入，推测是否需要 push：
     - 明确要 push："提交并推送"、"commit 并 push"、"提交代码到远程"、"保存并上传" → 标记为"需要 push"
     - 明确不要 push："只 commit"、"仅提交到本地"、"先不推送"、"不要 push" → 标记为"仅 commit"
     - 不明确："提交代码"、"commit"、"自动提交"、"保存修改" → **立即使用 AskUserQuestion 工具询问用户**
   - **关键**：这一步必须在第一步完成，类似 skill-creator 的模式，集中收集所有需要的用户输入

### 第二阶段：执行 Git 操作

2. 运行 `git status --short` 检查是否有变更
3. 如果有变更，运行 `git diff HEAD` 获取完整的变更内容（如果是新仓库，使用 `git diff` 或直接查看文件内容）
4. 分析 diff 输出，理解代码变更的性质和范围
5. 生成符合规范的 commit message（直接生成，无需用户确认）
6. 执行 `git add .`
7. 执行 `git commit -m "<generated-message>"`
8. 显示 commit 成功信息（commit hash、变更统计、commit message）

### 第三阶段：可选的 Push 操作

9. **根据第一步收集的用户意图执行 push**：
   - 如果需要 push：
     - 运行 `git remote -v` 检查远程仓库配置
     - 如果有配置，执行 `git push`
     - 显示 push 结果
     - 如果没有配置远程仓库，提示用户先配置 `git remote add origin <url>`
   - 如果不需要 push：
     - 提示："代码已成功提交到本地仓库，需要时可以运行 `git push` 推送到远程"

## 错误处理

- **没有变更**: 提示用户当前没有需要提交的变更
- **不在 git 仓库**: 提示用户当前目录不是 git 仓库
- **Commit 失败**: 显示错误信息，建议用户检查问题
- **有冲突文件**: 提示用户先解决冲突再提交
- **没有远程仓库**: 如果用户选择 push 但没有配置远程仓库，提示用户先运行 `git remote add origin <url>`
- **Push 失败**: 显示错误信息（如没有权限、网络问题等），建议用户检查并稍后手动 push

## 用户意图识别示例

**明确要求 Push：**
- "提交并推送"
- "commit 并 push"
- "提交代码到远程"
- "保存并上传"

**明确不需要 Push：**
- "只 commit"
- "仅提交到本地"
- "先不推送"
- "不要 push"

**不明确表达（需要询问）：**
- "提交代码"
- "commit"
- "自动提交"
- "保存修改"
- "提交这些改动"
