# api.plugins.turnOn()

用途：启用所有已安装插件。

签名：

```js
await api.plugins.turnOn();
```

返回：`Promise<void>`。

副作用：全局启用插件能力，可能改变后续代理行为。只在用户明确要求启用插件时执行。

操作建议：

- 执行前可用 `api.plugins.getStatus()` 或 `api.plugins.getList()` 记录当前状态。
- 完成后再次读取状态确认。
