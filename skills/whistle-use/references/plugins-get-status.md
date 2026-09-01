# api.plugins.getStatus()

用途：只读获取已安装插件的状态信息。

签名：

```js
const status = await api.plugins.getStatus();
```

返回：官方示例按数组使用：

```ts
Array<{
  name: string;
  moduleName: string;
  version: string;
  selected: boolean;
}>
```

实际字段可能随 Whistle 版本和插件元数据变化。

使用建议：

- 只需要插件启用状态时使用本 API。
- 需要插件规则、描述、主页等详细信息时用 `api.plugins.getList()`。

副作用：无。
