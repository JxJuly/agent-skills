# api.rules.get(ruleName)

用途：只读获取指定规则文件内容详情。

签名：

```js
const rule = await api.rules.get(ruleName);
```

参数：

- `ruleName: string`：规则文件名称，必须与规则列表中的名称精确匹配。

返回：

```ts
{
  value: string;
  selected: boolean;
}
```

字段可能随 Whistle 版本增加。

使用建议：

- 回答用户时可摘要规则内容，避免无意义地贴出过长规则。
- 规则内容可能包含内网地址、token、cookie 或账号信息，展示前默认脱敏。

副作用：无。
