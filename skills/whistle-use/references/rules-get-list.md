# api.rules.getList()

用途：只读获取所有规则文件。

签名：

```js
const rules = await api.rules.getList();
```

返回：

```ts
Array<{
  name: string;
  value: string;
  selected: boolean;
}>
```

使用建议：

- 只需要状态时优先 `api.rules.getStatus()`；需要规则内容时使用本 API。
- 展示列表时优先展示名称和 selected 状态；规则内容过长时只摘关键匹配行。
- 写入或选择规则前，用本 API 检查是否存在同名规则。

副作用：无。
