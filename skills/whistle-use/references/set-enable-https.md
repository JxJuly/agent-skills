# api.setEnableHTTPS(enable)

用途：启用或关闭 Whistle HTTPS 代理。

签名：

```js
await api.setEnableHTTPS(true);
await api.setEnableHTTPS(false);
```

参数：

- `enable: boolean`：`true` 启用 HTTPS 代理，`false` 关闭。

返回：`Promise<void>`。

副作用：会改变当前 Whistle 代理状态。只在用户明确要求启用或关闭 HTTPS 代理时执行。

安全边界：

- 不要自动安装根证书。
- 不要自动修改系统代理或系统信任设置。
- 设置前可先调用 `api.isEnabledHTTPS()`，避免重复操作。
