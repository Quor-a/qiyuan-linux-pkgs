# 启元 Linux 二进制包仓库 / Qiyuan Linux Binary Packages

**147 个预编译 `.qyp` 包**（1.2 GB）全部以 **GitHub Release 附件**发布。
仓库本体只放本 README、包清单 `PACKAGES.txt` 与仓库索引 `index.json` —— **构建产物不进 git**。
包用到的源码与构建配方（recipes，309 个 .py）在主仓库 [Quor-a/qiyuan-linux](https://github.com/Quor-a/qiyuan-linux)。

Release 地址：https://github.com/Quor-a/qiyuan-linux-pkgs/releases/tag/latest

---

## 一、终端怎么下载 & 安装

### 方式 A：单包下载 + qypkg 安装（最简单）
```sh
BASE=https://github.com/Quor-a/qiyuan-linux-pkgs/releases/latest/download

# 1) 下载你需要的包（例：mo 编译器）
curl -LO $BASE/mo-1.10.0-24.x86_64.qyp

# 2) 用 qypkg 安装（指定包文件）
sudo qypkg -U mo-1.10.0-24.x86_64.qyp
```

### 方式 B：配成本地仓库源，按名安装 + 自动解依赖（推荐）
```sh
BASE=https://github.com/Quor-a/qiyuan-linux-pkgs/releases/latest/download
mkdir -p /var/repo/x86_64 && cd /var/repo/x86_64

# 拉仓库索引
curl -LO $BASE/index.json

# 按 index.json 里的文件名下载所需包（下面脚本会全下，也可只下你需要的）
curl -LO $BASE/mo-1.10.0-24.x86_64.qyp

# 之后就能按包名安装，qypkg 会读 index.json 自动解析依赖
sudo qypkg --repo /var/repo --allow-unsigned install mo
```

### 方式 C：全量下载（1.2 GB）
```sh
BASE=https://github.com/Quor-a/qiyuan-linux-pkgs/releases/latest/download
curl -LO $BASE/PACKAGES.txt
while IFS=$'\t' read -r f ver mb desc; do
  case "$f" in \#*) continue;; esac
  curl -LO "$BASE/$f"
done < PACKAGES.txt
```
> 单文件超过 100 MB 的只有 `linux-firmware`（约 622 MB）；其余 146 个共 528 MB。

### 方式 D：用本仓库的下载脚本
```sh
curl -LO https://github.com/Quor-a/qiyuan-linux-pkgs/raw/main/dl.sh
bash dl.sh mo          # 只下 mo 相关
bash dl.sh all         # 全下到 ./pkgs
```

---

## 二、哪个包是哪个（主要包一览）

完整清单见 `PACKAGES.txt`（格式：文件名 ⇥ 版本 ⇥ 安装大小MB ⇥ 描述）与 `index.json`。

| 类别 | 包名（示例） | 说明 |
|---|---|---|
| **语言/工具链** | `mo-1.10.0-24` | 墨语言（启元官方系统开发语言）：自举编译器 moc + 标准库 + 工具链 |
| **基础系统** | `busybox`, `coreutils`, `util-linux`, `kmod` | 多合一工具箱 / 核心文件工具 / 挂载磁盘工具 / 内核模块 |
| **C 运行时/库** | `glibc`(按需), `zlib`, `zstd`, `brotli`, `expat` | C 库与压缩/XML 库 |
| **图形/桌面** | `cairo`, `fltk`, `atk`, `adwaita-icon-theme`, `libxkbcommon` | 2D 图形、轻量 GUI、无障碍、图标、键盘映射 |
| **网络** | `curl`, `bluez`, `iwd`, `ell` | HTTP 客户端 / 蓝牙 / 无线守护 |
| **浏览器** | `dillo` | 极轻量浏览器（自研引擎，约 1MB）；WebKitGTK 需额外 ruby 工具链 |
| **多媒体** | `alsa-lib`, `flac` | 音频库 |
| **大语言运行时** | `python-3.13.3`, `perl`, `lua` | ISO 内置的脚本语言；gcc/nodejs/JVM/rust 不进 ISO |
| **固件/内核** | `linux-firmware-20250613` | 硬件固件（大包 622 MB） |
| **打包/演示** | `qypkg`(随主仓库), `libqydemo` | 包管理器 / 构建演示共享库 |

> 查某个包是谁的依赖：`qypkg why <包名>`；查包内容：`qypkg -Qi <包名>`。

---

## 三、依赖关系
`qypkg install <包名>` 会自动解析并安装依赖（读 `index.json` 的 `depends`）。
用方式 A 单包下载时依赖需自己补齐——若不确定，用方式 B 按包名装。

## 四、校验
每个 Release 附件的 sha256 与主仓库 `var/repo/x86_64/index.json` 中该包的 `sha256` 字段一致。
下载后可对账：
```sh
sha256sum mo-1.10.0-24.x86_64.qyp          # 与 index.json 里 mo 的 sha256 比对
```

## 五、更新
每次主仓库发新版包，本仓库 Release `latest` 会滚动更新（同名附件替换）。
`curl -LO` 直接拉到最新版。历史版本可从主仓库 `var/repo` 自行构建。
