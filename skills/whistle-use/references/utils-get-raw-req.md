# api.utils.getRawReq(session)

用途：读取抓包 session 的原始请求报文。

签名：

```js
const rawRequest = api.utils.getRawReq(session);
```

参数：

- `session: object`：`api.network.getSessions()` 返回的单条抓包记录。

返回：原始请求字符串，通常包含请求行、请求头和请求体。

使用建议：

- 只在需要检查原始报文、header 顺序、换行、编码或 body 边界时使用。
- 输出前必须脱敏 `cookie`、`authorization`、token、session、账号信息和个人信息。
- 默认不要完整贴出大报文。

副作用：无。
