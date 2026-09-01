# api.values.add(name, value)

用途：新增 Value 或写入指定名称的 Value。

签名：

```js
await api.values.add(name, value);
```

参数：

- `name: string`：Value 名称。
- `value: string`：Value 内容。

返回：`Promise<void>`。

副作用：会改变 Whistle Values 配置。写入前先用 `api.values.get(name)` 检查是否已有同名 Value；如果已有且用户没有明确要求覆盖，先确认。

使用建议：

- 当规则需要引用较长内容时，可以先 `api.values.add()` 写入 Value，再在规则里引用该 Value。
- 不要把抓包中读到的敏感请求头或响应体原样写入 Values，除非用户明确要求。
