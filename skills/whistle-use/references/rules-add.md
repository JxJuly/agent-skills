# api.rules.add(name, value, selected)

用途：新增规则文件，并可选择是否立即选中。

签名：

```js
await api.rules.add(name, value, selected);
```

参数：

- `name: string`：规则名称。
- `value: string`：规则内容。
- `selected: boolean`：是否选中。

返回：`Promise<void>`。

副作用：创建或写入规则文件；如果 `selected` 为 true，会影响后续请求处理。

操作建议：

- 写入前用 `api.rules.get(name)` 或 `api.rules.getList()` 检查是否已有同名规则。
- 如果同名规则存在且用户没有明确要求覆盖，先确认。
- 对复杂规则，先向用户复述将写入的关键匹配和动作，再执行。
