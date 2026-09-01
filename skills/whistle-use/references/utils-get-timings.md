# api.utils.getTimings(session)

用途：读取单条抓包 session 的请求耗时分解。

签名：

```js
const timings = api.utils.getTimings(session);
```

参数：

- `session: object`：`api.network.getSessions()` 返回的单条抓包记录。

返回：耗时对象，常见字段包括：

```ts
{
  start?: number;
  ttfb?: number | null;
  dns?: number | null;
  connect?: number | null;
  request?: number | null;
  response?: number | null;
  download?: number | null;
  total?: number | null;
}
```

使用建议：

- 排查慢请求时优先展示 `total`、`ttfb`、`dns`、`connect`、`download`。
- 字段可能为空，按“该阶段无数据或不适用”解释。

副作用：无。
