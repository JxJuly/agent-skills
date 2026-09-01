# api.network.getFrames(options)

用途：按条件检索指定连接的 WebSocket/Socket 帧。使用抓包记录的 `id` 作为 `reqId`。

签名：

```js
const frames = await api.network.getFrames(options);
```

参数：

```ts
{
  reqId: string;             // 必填，对应 session.id
  count?: number;            // 期望最大帧数。包装函数可默认 3600；latest=true 时无效
  latest?: boolean;          // true 表示只取最新一页，最多约 120 条
  startId?: string | number; // 帧游标
  startTime?: number;        // Unix 毫秒时间戳
  from?: 'client' | 'server' | string;
}
```

过滤逻辑：

- `from: 'client'` 只取客户端到服务端。
- `from: 'server'` 只取服务端到客户端。
- 不传 `from` 或传其它值时返回全部方向。
- `latest: true` 只请求最新一页，最多约 120 条。
- 同时提供 `startId` 和 `startTime` 时，首轮请求以较新的起点为准；后续分页只使用 `startId`。

返回：`Promise<Array<Object>>`。常见字段：

```ts
{
  reqId: string;
  frameId: string;
  mask: boolean;
  compressed: boolean;
  length: number;
  opcode: number; // 1 文本帧，2 二进制帧
  base64?: string;
  body?: string;
  json?: object;
}
```

分页限制：

- 底层每次最多拉取约 120 条。
- 自动分页时，用上一页最后一条帧的 `frameId` 作为下一页 `startId`，并清空 `startTime`。
- `startId` 是“大于”语义，只能向更晚时间滚动。
- 如果没有 `startId` 或 `startTime`，通常只能获取最新第一页；要拉大量历史帧，需要先获得较早的 `startId`。

示例：

```js
const frames = await api.network.getFrames({
  reqId: '1784885309943-086',
  latest: true
});

const clientFrames = await api.network.getFrames({
  reqId: '1784885309943-086',
  startId: '1784903620142-000',
  count: 10,
  from: 'client'
});
```

使用建议：

- 先用 `api.network.getSessions({ type: 'WS' })` 或 URL 过滤找到目标连接，再用该 session 的 `id` 查询帧。
- 文本帧可结合 `api.utils.getText(frame)` 解码；JSON 解析失败时回退为文本摘要。
- 二进制帧不要盲目展开完整 `base64`，除非用户明确需要。

副作用：无。
