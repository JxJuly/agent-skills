# api.plugins.getList()

用途：只读获取当前已安装插件的详细列表。

签名：

```js
const plugins = await api.plugins.getList();
```

返回：

```ts
Array<{
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
}>
```

字段说明：

- `moduleName`：插件模块名，如 `whistle.inspect`。
- `name`：插件短名称，如 `inspect`。
- `rules`、`_rules`、`resRules`：插件关联规则，可能为空或包含动态逻辑。
- `selected`：当前是否启用该插件。

使用建议：

- 展示给用户时优先列 `name`、`version`、`selected` 和 `description`。
- 插件规则可能包含敏感信息，输出前默认脱敏。

副作用：无。
