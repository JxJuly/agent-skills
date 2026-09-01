# api.utils.getRawRes(session)

用途：读取抓包 session 的原始响应报文。

签名：

```js
const rawResponse = api.utils.getRawRes(session);
```

参数：

- `session: object`：`api.network.getSessions()` 返回的单条抓包记录。

返回：原始响应字符串，通常包含状态行、响应头和响应体。

使用建议：

- 只在需要检查原始响应头、编码、压缩、chunk 或 body 边界时使用。
- 输出前必须脱敏 token、cookie、用户信息和其它敏感字段。
- 默认不要完整贴出大报文。

副作用：无。
