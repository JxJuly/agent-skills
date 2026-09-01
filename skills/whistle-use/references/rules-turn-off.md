# api.rules.turnOff()

用途：全局关闭 Whistle 普通规则引擎，不包括插件规则。

签名：

```js
await api.rules.turnOff();
```

返回：`Promise<void>`。

副作用：所有普通规则立即失效，后续请求不再按普通 Rules 处理。只在用户明确要求关闭规则时执行。

操作建议：

- 执行前可先调用 `api.rules.getStatus()`，记录当前 `disabled` 状态。
- 完成后再次调用 `api.rules.getStatus()` 确认状态。
