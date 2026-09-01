# api.getFile(filePath)

用途：读取 Whistle 可访问的指定文件内容。

签名：

```js
const content = await api.getFile(filePath);
```

参数：

- `filePath: string`：通常是 `api.createFile(data)` 返回的路径，也可以是 Whistle 可访问的文件路径。

返回：`Promise<string>`。

使用建议：

- 读取前确认路径来自 Whistle API 或用户明确提供。
- 输出文件内容前检查是否包含密钥、token、cookie、账号信息或个人信息。

副作用：无。
