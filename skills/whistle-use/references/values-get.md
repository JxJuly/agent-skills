# api.values.get(name)

用途：只读获取指定 Value。

签名：

```js
const value = await api.values.get(name);
```

参数：

- `name: string`：Value 名称。

返回：

```ts
{
  name: string;
  value: string;
} | null | undefined
```

使用建议：

- 不存在时按 `null` 或 `undefined` 处理。
- 输出 `value` 前检查是否包含密钥、token、cookie、邮箱、手机号、账号信息等。

副作用：无。
