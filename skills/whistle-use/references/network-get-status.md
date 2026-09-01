# api.network.getStatus()

用途：只读检查 Whistle 服务和 Local Agent API 是否可连接，并获取版本等运行状态。

签名：

```js
const status = await api.network.getStatus();
```

返回：状态对象，至少关注 `version`。其它字段可能随 Whistle 版本变化。

典型用法：

```js
const api = await loadApi();
const status = await api.network.getStatus();
console.log(status.version);
```

错误处理：

- 无运行实例时，提示用户启动 Whistle，或在用户明确同意时运行 `w2 start`。
- 如果 `w2 status` 显示 running 但 Local Agent API 仍访问失败，停止读取抓包并说明 Local Agent API 当前不可用；不要用浏览器、`curl`、`fetch`、`axios` 或其它 HTTP 客户端改读 Whistle Web UI、`127.0.0.1:8899`、`/cgi-bin/*` 等 HTTP/UI 接口。

副作用：无。
