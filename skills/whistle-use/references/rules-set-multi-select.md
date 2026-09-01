# api.rules.setMultiSelect(enable)

用途：设置 Rules 是否启用多选模式。

签名：

```js
await api.rules.setMultiSelect(true);
await api.rules.setMultiSelect(false);
```

参数：

- `enable: boolean`：是否启用多选。

返回：`Promise<void>`。

副作用：改变 Rules 面板选择行为，并影响后续 `api.rules.select(ruleName)` 的效果。只在用户明确要求时执行。

操作建议：

- 设置前可用 `api.rules.isMultiSelect()` 或 `api.rules.getStatus()` 读取当前状态。
- 设置后用 `api.rules.getStatus()` 验证。
