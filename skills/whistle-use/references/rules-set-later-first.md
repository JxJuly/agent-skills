# api.rules.setLaterFirst(enable)

用途：设置是否启用后置规则优先。官方 JSDoc 的函数名写作 `setLaterRulesFirst`，实际调用为 `api.rules.setLaterFirst(enable)`。

签名：

```js
await api.rules.setLaterFirst(true);
await api.rules.setLaterFirst(false);
```

参数：

- `enable: boolean`：是否启用后置规则优先。

返回：`Promise<void>`。

副作用：改变规则优先级策略，可能影响所有后续请求的规则匹配结果。

操作建议：

- 设置前读取 `api.rules.getStatus()`，确认当前 `laterRulesFirst`。
- 设置后再次读取 `getStatus()` 验证。
