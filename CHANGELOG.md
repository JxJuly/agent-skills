# Changelog | 变更日志

## [0.0.3](https://github.com/JxJuly/agent-skills/compare/v0.0.2...v0.0.3) (2026-04-09)

### 🌟 Features | 新功能

* 新增 package-json-fix skill ([924a714](https://github.com/JxJuly/agent-skills/commit/924a7142c6cc8b01f89aae2d44f6b2d46fdda425))

### 🔄 Refactor | 重构代码

* 将脚本路径改为相对路径，使技能不依赖特定平台 ([22f06a3](https://github.com/JxJuly/agent-skills/commit/22f06a319ed163df72d3c102b28828346a8ed4d2))

### 🔧 Chore | 日常维护

* 升级 release-it action 至 v0.0.5 并传入 github_token ([746641e](https://github.com/JxJuly/agent-skills/commit/746641efdc188883fc4429e619260e521bcf1dfd))

## 0.0.2 (2026-03-26)

### 🌟 Features | 新功能

* 优化 git-commit skill 增加智能 push 询问功能 ([5cea42f](https://github.com/JxJuly/agent-skills/commit/5cea42f653e176d276afdeda9af5a05a2e6474f1))
* 初始化 CLI 脚手架项目并优化 git-commit skill ([6d14bda](https://github.com/JxJuly/agent-skills/commit/6d14bdae68da930be4b6c4e2d0689d147a4e3640))

### 🐛 Bug Fixes | Bug 修复

* 传递 github_token 给 release-it composite action ([8a7f1e8](https://github.com/JxJuly/agent-skills/commit/8a7f1e8245d4477113fe3fd4b02248ef6ad2f5de))

### 🔄 Refactor | 重构代码

* 优化 git-commit skill 描述和结构 ([8c99b5b](https://github.com/JxJuly/agent-skills/commit/8c99b5b1420362eb3e296c6e43bbc86f903aa1b0))
* 优化 git-commit skill 采用集中信息收集模式 ([1fb7a1f](https://github.com/JxJuly/agent-skills/commit/1fb7a1f87a8691ea2bcf317bd56f773550d1c52f))
* 简化 release workflow 使用复用 actions ([b2859ea](https://github.com/JxJuly/agent-skills/commit/b2859ea343190eb49602b136002ee82a1c90a38e))
* 精简 git-commit skill 文档以减少 token 消耗 ([e476d70](https://github.com/JxJuly/agent-skills/commit/e476d70b265ba2a6c7397dcd65d3229151419fd6))

### 🎨 Style | 代码格式调整

* 优化 git-commit 技能文档结构 ([b03f6f6](https://github.com/JxJuly/agent-skills/commit/b03f6f676b513145406963f8a9f81c5ea2a74310))

### 🔧 Chore | 日常维护

* 初始化项目结构 ([c5a9ad7](https://github.com/JxJuly/agent-skills/commit/c5a9ad7623c5bd4dad587158f1868bc1d74ebda2))
