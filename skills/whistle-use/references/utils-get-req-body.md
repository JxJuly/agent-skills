# api.utils.getReqBody(session)

用途：从抓包 session 中读取请求体文本。

签名：

```js
const body = api.utils.getReqBody(session);
```

参数：

- `session: object`：`api.network.getSessions()` 返回的单条抓包记录。

返回：请求体字符串；没有请求体时通常为空字符串或空值，按 Whistle 版本表现处理。

使用建议：

- 读取表单请求时，如果 `content-type` 匹配 `application/x-www-form-urlencoded`，可用 `querystring.parse(body)` 转对象。
- 输出前脱敏 token、cookie、密码、邮箱、手机号、账号 ID 等敏感信息。

副作用：无。
