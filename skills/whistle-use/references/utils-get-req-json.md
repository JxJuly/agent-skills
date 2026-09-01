# api.utils.getReqJson(session)

用途：从抓包 session 中读取解析后的 JSON 请求体。

签名：

```js
const json = api.utils.getReqJson(session);
```

参数：

- `session: object`：`api.network.getSessions()` 返回的单条抓包记录。

返回：解析后的对象；非 JSON 或解析失败时按 Whistle 版本可能返回空对象或空值。

使用建议：

- 如果该 helper 不能解析但请求体存在，回退到 `api.utils.getReqBody(session)`。
- `application/x-www-form-urlencoded` 请求可用 `querystring.parse(body)` 解析。
- 输出前脱敏敏感字段。

副作用：无。
