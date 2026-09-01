# api.createFile(data)

用途：通过 Whistle API 创建临时文件并写入内容。

签名：

```js
const filePath = await api.createFile(data);
```

参数：

- `data: Buffer | string`：要写入的内容。

返回：`Promise<string>`，示例路径类似：

```text
temp/7d2e9a424672279e5bcaab948a7a63fd47cb381626555835e828438762f86a96
```

副作用：会在 Whistle 管理的临时目录中创建文件。

使用建议：

- 只在规则、插件或调试流程需要 Whistle 可引用的临时文件时使用。
- 不要把抓包中的敏感请求头、token、cookie 或私密响应体原样写入临时文件，除非用户明确要求。
