# api.getRootCA()

用途：读取 Whistle 根证书内容。

签名：

```js
const cert = await api.getRootCA();
```

返回：`Promise<Buffer>`。

典型用途：

- 将证书保存为 `.crt` 文件，便于用户手动安装或检查。
- 排查 HTTPS 解密失败时确认 Whistle 是否能提供根证书。

安全边界：

- 读取证书是只读操作。
- 保存证书文件属于本地写入，需写到允许的工作目录。
- 安装或信任根证书是高影响系统变更，必须由用户明确要求。
