# api.plugins.unselect(name)

用途：取消选择/禁用指定插件。

签名：

```js
const result = await api.plugins.unselect(name);
```

参数：

- `name: string`：插件名称。

返回：`Promise<boolean>`，表示插件是否存在或操作是否成功。

副作用：改变插件启用状态，可能导致相关规则或扩展功能失效。

操作建议：

- 先用 `api.plugins.get(name)` 或 `api.plugins.getList()` 确认插件存在。
- 如果用户要求禁用所有插件，使用 `api.plugins.turnOff()`；如果只禁用一个插件，使用本 API。
