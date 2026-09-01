# api.plugins.turnOff()

用途：禁用所有已安装插件。

签名：

```js
await api.plugins.turnOff();
```

返回：`Promise<void>`。

副作用：全局禁用插件能力，可能导致插件规则、插件 UI 或插件扩展能力失效。只在用户明确要求禁用插件时执行。

操作建议：

- 如果用户只想禁用某个插件，应使用 `api.plugins.unselect(name)`，不要使用全局 `turnOff()`。
- 完成后用 `api.plugins.getStatus()` 验证。
