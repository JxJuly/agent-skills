---
name: whistle-use
description: 当用户提到 whistle 或 ws2，并要用 Whistle Local Agent API 抓包、查找接口请求、读取 Network/WS 记录，或管理 Rules/Values/Plugins 时使用。
---

# Whistle Use

使用 Whistle Local Agent API 以编程方式检查本机 Whistle 状态、读取抓包记录、管理规则、Values、插件、HTTPS 代理和根证书。优先把 Whistle 当作可观测工具使用；会改变 Whistle 状态的操作必须确认用户意图足够明确。

官方 API 文档来源：`https://wproxy.org/docs/extensions/api.html`。Whistle 需已全局安装，且版本 `>= 2.10.7`。

## 重要规则

- 该 skill 的所有 Whistle 操作都需要在沙箱外执行，因为 Agent 沙箱内可能看不到宿主机正在运行的 Whistle 实例或 Local Agent API 连接状态。
- 只允许通过 `whistle root bin/api` 或 `w2 root bin/api` 加载出的 Local Agent API 对象操作 Whistle。不要用浏览器、`curl`、`fetch`、`axios` 或其它 HTTP 客户端读取 Whistle Web UI、`127.0.0.1:8899`、`/cgi-bin/*` 等内部 HTTP/UI 接口。

## Reference 路由

每个 Whistle Local Agent API 都有独立 reference。不要一次性读取所有 reference；只读当前任务需要的方法。跨 API 任务再补读相应文档，例如“新增规则后确认接口是否命中”需要先读 `rules-add.md`，再读 `network-get-sessions.md`。

基础能力：

- 启动、连接和版本检查：读 [references/load-api.md](references/load-api.md)。
- 查询 Whistle 运行状态：读 [references/network-get-status.md](references/network-get-status.md)。
- 查询或设置 HTTPS 代理：读 [references/is-enabled-https.md](references/is-enabled-https.md) 或 [references/set-enable-https.md](references/set-enable-https.md)。
- 读取根证书：读 [references/get-root-ca.md](references/get-root-ca.md)。
- 创建或读取 Whistle 临时文件：读 [references/create-file.md](references/create-file.md) 或 [references/get-file.md](references/get-file.md)。

Rules：

- 状态和列表：读 [references/rules-get-status.md](references/rules-get-status.md)、[references/rules-get-list.md](references/rules-get-list.md) 或 [references/rules-get.md](references/rules-get.md)。
- 启停和选择：读 [references/rules-turn-on.md](references/rules-turn-on.md)、[references/rules-turn-off.md](references/rules-turn-off.md)、[references/rules-select.md](references/rules-select.md) 或 [references/rules-unselect.md](references/rules-unselect.md)。
- 多选、优先级、创建和排序：读 [references/rules-is-multi-select.md](references/rules-is-multi-select.md)、[references/rules-set-multi-select.md](references/rules-set-multi-select.md)、[references/rules-set-later-first.md](references/rules-set-later-first.md)、[references/rules-add.md](references/rules-add.md) 或 [references/rules-move-to-top.md](references/rules-move-to-top.md)。

Values：

- 读 [references/values-get-list.md](references/values-get-list.md)、[references/values-get.md](references/values-get.md) 或 [references/values-add.md](references/values-add.md)。

Plugins：

- 状态、列表和详情：读 [references/plugins-get-status.md](references/plugins-get-status.md)、[references/plugins-get-list.md](references/plugins-get-list.md) 或 [references/plugins-get.md](references/plugins-get.md)。
- 启停和选择：读 [references/plugins-turn-on.md](references/plugins-turn-on.md)、[references/plugins-turn-off.md](references/plugins-turn-off.md)、[references/plugins-select.md](references/plugins-select.md) 或 [references/plugins-unselect.md](references/plugins-unselect.md)。

Network：

- 查询抓包记录：读 [references/network-get-sessions.md](references/network-get-sessions.md)。
- 查询 WebSocket/Socket 帧：读 [references/network-get-frames.md](references/network-get-frames.md)。
- 解析请求/响应体：读 [references/utils-get-req-body.md](references/utils-get-req-body.md)、[references/utils-get-res-body.md](references/utils-get-res-body.md)、[references/utils-get-req-json.md](references/utils-get-req-json.md) 或 [references/utils-get-res-json.md](references/utils-get-res-json.md)。
- 解析原始报文、命中规则、耗时、帧文本：读 [references/utils-get-raw-req.md](references/utils-get-raw-req.md)、[references/utils-get-raw-res.md](references/utils-get-raw-res.md)、[references/utils-get-rules.md](references/utils-get-rules.md)、[references/utils-get-timings.md](references/utils-get-timings.md) 或 [references/utils-get-text.md](references/utils-get-text.md)。

## 安全边界

只读操作：`network.getStatus`、`network.getSessions`、`network.getFrames`、`isEnabledHTTPS`、`getRootCA`、`getFile`、`rules.getStatus`、`rules.getList`、`rules.get`、`rules.isMultiSelect`、`values.getList`、`values.get`、`plugins.getStatus`、`plugins.getList`、`plugins.get`。

会改变 Whistle 状态：`setEnableHTTPS`、`createFile`、`rules.turnOff`、`rules.turnOn`、`rules.select`、`rules.unselect`、`rules.setMultiSelect`、`rules.setLaterFirst`、`rules.add`、`rules.moveToTop`、`values.add`、`plugins.turnOn`、`plugins.turnOff`、`plugins.select`、`plugins.unselect`。除非用户明确要求对应状态变更，否则不要执行。

不要为了抓包自动修改系统代理、安装根证书或开启 HTTPS 解密。可以说明需要用户手动开启，或在用户明确授权后操作。

输出抓包、规则、Values 或插件内容时，先给结论和关键事实；只展示与问题相关的摘要，并默认脱敏 `cookie`、`authorization`、`token`、`session`、`ticket`、`csrf`、`passport`、邮箱、手机号、账号 ID、用户 ID、客户端 IP 等敏感信息。具体排障路径放在对应 reference 中。

## Troubleshooting

如果 Local Agent API 加载失败、`api.network.getStatus()` 不通，或出现 `No running Whistle instances` / `No running Whistle client` 等错误，正常向用户报告错误和已执行的只读检查即可；禁止改用任何 Whistle UI 或 UI 内部接口兜底。
