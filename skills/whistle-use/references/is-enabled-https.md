# api.isEnabledHTTPS()

用途：只读判断当前 Whistle 是否启用了 HTTPS 代理。

签名：

```js
const enabled = await api.isEnabledHTTPS();
```

返回：`Promise<boolean>`。

典型用法：

```js
const api = await loadApi();
const enabled = await api.isEnabledHTTPS();
console.log(enabled ? 'HTTPS enabled' : 'HTTPS disabled');
```

使用建议：

- 用户看不到 HTTPS 明文或只看到 `CONNECT` 时，先用本 API 检查开关。
- 即使 HTTPS 已启用，客户端仍可能没有安装或信任 Whistle 根证书。

副作用：无。
