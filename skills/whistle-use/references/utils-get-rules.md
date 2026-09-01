# api.utils.getRules(session)

用途：读取单条抓包 session 命中的 Whistle 规则。

签名：

```js
const rules = api.utils.getRules(session);
```

参数：

- `session: object`：`api.network.getSessions()` 返回的单条抓包记录。

返回：规则数组；需要展示原始文本时可 `rules.join('\n')`。

使用建议：

- 排查“为什么这个请求被改写/代理/mock/注入”时优先使用。
- 规则内容可能包含内网域名、路径、token 或账号信息，输出前默认脱敏。

副作用：无。
