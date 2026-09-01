# api.rules.select(ruleName)

用途：选中/激活指定规则文件。官方示例中，成功后会再调用 `api.rules.turnOn()`，确保规则引擎启用。

签名：

```js
const exists = await api.rules.select(ruleName);
if (exists) {
  await api.rules.turnOn();
}
```

参数：

- `ruleName: string`：规则文件名称，必须与规则列表中的名称精确匹配。

返回：`Promise<boolean>`，表示对应规则是否存在或操作是否成功。

副作用：改变规则激活状态，可能改变后续请求处理。

操作建议：

- 先用 `api.rules.getList()` 或 `api.rules.getStatus()` 确认规则存在。
- 注意 `multiSelect`：非多选模式下选择一个规则可能影响其它规则的选中状态。
