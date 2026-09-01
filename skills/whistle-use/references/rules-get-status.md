# api.rules.getStatus()

用途：只读获取 Whistle 规则引擎状态、规则列表、启用状态和优先级策略。

签名：

```js
const status = await api.rules.getStatus();
```

返回：

```ts
{
  laterRulesFirst: boolean;
  multiSelect: boolean;
  pluginsDisabled: boolean;
  disabled: boolean;
  list: Array<{
    name: string;
    selected: boolean;
  }>;
}
```

重点字段：

- `disabled`：是否全局禁用普通规则。
- `pluginsDisabled`：是否全局禁用插件规则。
- `multiSelect`：是否允许多个规则同时选中。
- `laterRulesFirst`：是否后置规则优先。
- `list[].selected`：该规则文件当前是否激活。

副作用：无。
