# api.rules.moveToTop(ruleName)

用途：将指定规则文件移动到规则列表顶部。

签名：

```js
await api.rules.moveToTop(ruleName);
```

参数：

- `ruleName: string`：规则文件名称，必须与规则列表中的名称精确匹配。

返回：`Promise<void>`。

副作用：改变规则排序。在非后置规则优先模式下，排序变化尤其可能改变匹配优先级。

操作建议：

- 执行前用 `api.rules.getStatus()` 确认 `laterRulesFirst` 和当前规则列表。
- 完成后用 `api.rules.getStatus()` 或 `api.rules.getList()` 验证排序。
