# api.rules.isMultiSelect()

用途：只读判断 Rules 是否启用多选模式。

签名：

```js
const multiSelect = await api.rules.isMultiSelect();
```

返回：`Promise<boolean>`。

使用建议：

- 在执行 `api.rules.select(ruleName)` 前可先检查多选模式。
- 非多选模式下，选择一条规则可能影响其它规则的选中状态。

副作用：无。
