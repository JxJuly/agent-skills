# api.plugins.get(name)

用途：只读获取指定插件详情。

签名：

```js
const plugin = await api.plugins.get(name);
```

参数：

- `name: string`：插件名称。

返回：与 `api.plugins.getList()` 单项类似；不存在时可能返回 `null` 或 `undefined`。

常见字段：

```ts
{
  moduleName: string;
  name: string;
  mtime: number;
  version: string;
  description: string;
  homepage: string;
  rules: string;
  _rules: string;
  resRules: string;
  selected: boolean;
}
```

使用建议：

- 选择或取消选择插件前，先用本 API 确认目标插件存在。
- 插件规则内容输出前默认脱敏。

副作用：无。
