# api.utils.getResJson(session)

用途：从抓包 session 中读取解析后的 JSON 响应体。

签名：

```js
const json = api.utils.getResJson(session);
```

参数：

- `session: object`：`api.network.getSessions()` 返回的单条抓包记录。

返回：解析后的对象；非 JSON 或解析失败时按 Whistle 版本可能返回空对象或空值。

使用建议：

- 如果接口返回不是 JSON，回退到 `api.utils.getResBody(session)` 输出短文本摘要。
- 避免整段输出大响应；只展示与用户问题相关的字段。
- 输出前脱敏敏感字段。

副作用：无。
