# api.utils.getResBody(session)

用途：从抓包 session 中读取响应体文本。

签名：

```js
const body = api.utils.getResBody(session);
```

参数：

- `session: object`：`api.network.getSessions()` 返回的单条抓包记录。

返回：响应体字符串；没有响应体时通常为空字符串或空值，按 Whistle 版本表现处理。

使用建议：

- 响应很大时只输出相关字段或前若干字符摘要。
- 若响应是 JSON，可先尝试 `JSON.parse(body)`。
- 输出前脱敏 token、cookie、用户信息和其它敏感字段。

副作用：无。
