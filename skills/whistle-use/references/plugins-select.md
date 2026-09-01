# api.plugins.select(name)

用途：选择/启用指定插件。官方示例中，成功后会再调用 `api.plugins.turnOn()`，确保插件全局启用。

签名：

```js
const result = await api.plugins.select(name);
if (result) {
  await api.plugins.turnOn();
}
```

参数：

- `name: string`：插件名称。

返回：`Promise<boolean>`，表示插件是否存在或操作是否成功。

副作用：改变插件启用状态，并可能影响后续请求处理。

操作建议：

- 先用 `api.plugins.get(name)` 或 `api.plugins.getList()` 确认插件存在。
- 对用户说明会启用哪个插件，以及启用后可能影响代理规则/扩展行为。
