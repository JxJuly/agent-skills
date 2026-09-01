# loadApi

用途：加载 Whistle Local Agent API，并确认 Whistle 版本满足 `>= 2.10.7`。

官方示例：

```js
const cp = require('child_process');
const loadModule = require;
let w2Api;

const loadApi = async () => {
  if (!w2Api) {
    w2Api = loadModule(cp.spawnSync('w2', ['root', 'bin/api']).stdout.toString().trim());
  }
  const { version } = await w2Api.network.getStatus();
  const [major, minor, patch] = version.split('.').map(Number);
  w2Api.version = version;
  if (major > 2 || (major == 2 && (minor > 10 || (minor == 10 && patch >= 7)))) {
    return w2Api;
  }
  throw new Error('Whistle version must be >= 2.10.7');
};
```

实践建议：

- 先运行 `command -v w2` 和 `w2 -V` 确认 CLI 可用。
- 用 `w2 root bin/api` 定位 API 模块。
- Homebrew 安装时返回路径可能没有 `.js` 后缀；若该路径不存在但 `${apiPath}.js` 存在，使用后者。
- 通过 `api.network.getStatus()` 校验连接和版本。
- 缓存加载结果，避免重复 `require`。
- 只使用该 Local Agent API 路径和加载出的 API 对象；不要用浏览器、`curl`、`fetch`、`axios` 或其它 HTTP 客户端读取 Whistle Web UI、`127.0.0.1:8899` 或 `/cgi-bin/*` HTTP/UI 接口兜底。

常见失败：

- `w2` 不存在：提示用户安装 Whistle 或修正 `PATH`。
- `No running Whistle instances`：Whistle 服务未启动。
- `No running Whistle client`：Local Agent API 当前不可用；停止读取抓包，向用户说明需要启动/连接 Whistle Client 或修复 Local Agent API 状态，不要改走 Web UI/HTTP 接口。
- `Whistle version must be >= 2.10.7`：需要升级 Whistle。
