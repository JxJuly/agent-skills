# api.utils.getText(frame)

用途：从 WebSocket/Socket frame 中解码可读文本。

签名：

```js
const text = api.utils.getText(frame);
```

参数：

- `frame: object`：`api.network.getFrames()` 返回的单条帧记录。

返回：帧文本内容。

使用建议：

- `opcode === 1` 通常表示文本帧，可优先解码并尝试 JSON.parse。
- `opcode === 2` 通常表示二进制帧，不要盲目展开完整 `base64`。
- 输出前脱敏 token、session、账号信息、手机号、邮箱等。

副作用：无。
