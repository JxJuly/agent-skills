# api.rules.turnOn()

用途：全局启用 Whistle 普通规则引擎。

签名：

```js
await api.rules.turnOn();
```

返回：`Promise<void>`。

副作用：已选中的普通规则会恢复生效，影响后续请求处理。只在用户明确要求开启规则时执行。

操作建议：

- 如果用户是“启用某条规则”，通常调用 `api.rules.select(ruleName)` 后再确保 `api.rules.turnOn()`。
- 完成后可用 `api.rules.getStatus()` 验证 `disabled` 是否为 false。
