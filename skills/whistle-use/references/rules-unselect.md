# api.rules.unselect(ruleName)

用途：取消选中/停用指定规则文件。官方说明：`ruleName` 不填则取消所有规则。

签名：

```js
const result = await api.rules.unselect(ruleName);
```

参数：

- `ruleName?: string`：要取消激活的规则名称；不填则取消所有规则。

返回：`Promise<boolean>`，表示对应规则是否存在或操作是否成功。

副作用：改变规则激活状态；不填参数的影响范围更大，必须确保用户明确要求取消所有规则。

操作建议：

- 单条规则操作前先确认规则存在。
- 不要把“关闭规则引擎”和“取消选中规则”混用：前者是 `api.rules.turnOff()`，后者改变选中项。
