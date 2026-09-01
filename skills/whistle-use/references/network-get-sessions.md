# api.network.getSessions(options)

用途：按条件检索 HTTP/WebSocket 等协议的抓包记录。适合查接口是否发出、状态码、请求/响应摘要、耗时、命中规则和基础排障。

签名：

```js
const sessions = await api.network.getSessions(options);
```

参数：

```ts
{
  count?: number;             // 期望最大记录数。包装函数可默认 3600；latest=true 时无效
  latest?: boolean;           // true 表示只取最新一页，最多约 120 条
  startId?: string | number;  // 游标 ID，获取 ID 大于它的更新记录
  startTime?: number;         // Unix 毫秒时间戳，获取晚于它的记录
  type?: string;              // 资源类型过滤
  subUrl?: string;            // URL 包含的子串，不区分大小写
  method?: string | string[]; // HTTP 方法，数组或逗号分隔字符串均可
  statusCode?: number | number[];
  reqHeader?: { name: string; subValue?: string };
  resHeader?: { name: string; subValue?: string };
}
```

过滤逻辑：

- 所有非空条件以 AND 关系叠加。
- `method` 和 `statusCode` 传多个值时为 OR 关系。
- `reqHeader` 和 `resHeader` 按字段名和值做子串匹配；不传 `subValue` 表示只要求该 header 存在。
- `latest: true` 优先级最高，只请求最新一页，最多约 120 条。
- 同时提供 `startId` 和 `startTime` 时，首轮请求以较新的起点为准；后续分页只使用 `startId`。

`type` 可用值：

- `JSON`
- `HTML`
- `CSS`
- `JS`
- `Font`
- `Img`
- `Media`
- `WS`
- `Tunnel`
- `Wasm`
- `Mock`
- `Rules`
- `Import`
- `Composer`
- `Error`
- `captureError`

返回：`Promise<Array<Object>>`。常见字段：

```ts
{
  id: string;        // 记录 ID，如 "1785144349945-573"
  startTime: number; // Unix 毫秒
  url: string;
  req: {
    method: string;
    ip: string;
    port: string;
    headers: Record<string, string>;
    body?: string;
    raw?: string;
    json?: object;
  };
  res: {
    ip: string;
    port: string;
    statusCode: number;
    headers: Record<string, string>;
    body?: string;
    raw?: string;
    json?: object;
  };
  timings?: object;
  rules?: object;
  rawRules?: string;
  version?: string;
  nodeVersion?: string;
  dnsTime?: number;
  requestTime?: number;
  connectTime?: number;
  responseTime?: number;
  endTime?: number;
}
```

分页限制：

- 底层每次最多拉取约 120 条。
- 自动分页时，用上一页最后一条记录的 `id` 作为下一页 `startId`，并清空 `startTime`。
- `startId` 是“大于”语义，只能向更晚时间滚动。
- 如果没有 `startId` 或 `startTime`，通常只能获取最新第一页；要拉大量历史记录，需要先获得较早的 `startId`。

示例：

```js
const latestJson = await api.network.getSessions({
  latest: true,
  type: 'JSON',
  subUrl: '/v1'
});

const sessions = await api.network.getSessions({
  subUrl: '/v1',
  method: 'GET',
  statusCode: [200, 304],
  reqHeader: { name: 'X-Token', subValue: 'abc' },
  count: 50
});
```

输出建议：

- 默认展示方法、URL、状态码、Content-Type、耗时和命中规则摘要。
- 展示请求/响应体时只贴与问题相关的字段。
- 默认脱敏 `cookie`、`authorization`、`token`、`session`、`ticket`、`csrf`、`passport`、邮箱、手机号、账号 ID、用户 ID、客户端 IP。

常见排查：

- 找不到请求：确认 `subUrl` 大小写/路径正确，再确认客户端流量经过 Whistle。
- 状态码为空或只看到 `CONNECT`：可能是 HTTPS 未解密。
- SSE/WS 没普通响应体：先用 `type: 'WS'` 或 `type: 'Tunnel'` 找连接，再读 `network-get-frames.md`。

副作用：无。
