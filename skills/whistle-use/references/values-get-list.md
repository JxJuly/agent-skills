# api.values.getList()

用途：只读获取当前配置的 Values 列表。

签名：

```js
const values = await api.values.getList();
```

返回：

```ts
Array<{
  name: string;
  value: string;
}>
```

使用建议：

- Values 可能包含 token、cookie、账号信息、mock 响应或其它敏感内容，展示前默认脱敏。
- 列表很长时，优先展示名称和与任务相关的摘要。

副作用：无。
