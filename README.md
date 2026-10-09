# 启元 Linux 二进制包仓库 / Qiyuan Linux Binary Packages

**147 个预编译 `.qyp` 包**（1.2 GB）全部以 **GitHub Release 附件**发布。
仓库本体只放本 README、包清单 `PACKAGES.txt`、仓库索引 `index.json` 与下载脚本 `dl.sh` —— **构建产物不进 git**。
源码与构建配方（recipes，309 个 .py）在主仓库 [Quor-a/qiyuan-linux](https://github.com/Quor-a/qiyuan-linux)。

Release：https://github.com/Quor-a/qiyuan-linux-pkgs/releases/tag/latest

---

## 一、终端怎么下载 & 安装

### 方式 A：单包下载 + qypkg 安装
```sh
BASE=https://github.com/Quor-a/qiyuan-linux-pkgs/releases/latest/download
curl -LO $BASE/mo-1.10.0-25.x86_64.qyp   # 下你要的包（文件名见下方总表）
sudo qypkg -U mo-1.10.0-25.x86_64.qyp     # 安装
```

### 方式 B：配成本地仓库源，按包名装 + 自动解依赖（推荐）
```sh
BASE=https://github.com/Quor-a/qiyuan-linux-pkgs/releases/latest/download
mkdir -p /var/repo/x86_64 && cd /var/repo/x86_64
curl -LO $BASE/index.json
curl -LO $BASE/mo-1.10.0-25.x86_64.qyp    # 需要的包（含依赖）都下到本目录
sudo qypkg --repo /var/repo --allow-unsigned install mo   # 按包名装，自动解依赖
```
> qypkg 只读 `index.json` 解析依赖；`index.json` 里每个包的 `filename` 就是该下哪个文件。

### 方式 C：全量下载（1.2 GB）
```sh
BASE=https://github.com/Quor-a/qiyuan-linux-pkgs/releases/latest/download
curl -LO $BASE/PACKAGES.txt
curl -LO $BASE/dl.sh && bash dl.sh all      # 全下到 ./pkgs
```

### 方式 D：只下几类（关键词匹配）
```sh
bash dl.sh mo python lua    # 只下文件名含这些关键词的包
```

## 二、怎么知道哪个包是哪个
- **看下方「全部 147 个包一览」总表**：包文件名 → 版本 → 装后大小 → 中文说明 → 依赖。
- **`PACKAGES.txt`**：同样内容的机器可读纯文本，适合 `grep`：
  ```sh
  curl -LO $BASE/PACKAGES.txt
  grep 浏览器 PACKAGES.txt        # 找浏览器相关
  grep -i python PACKAGES.txt     # 找 python 相关
  ```
- **装好后**：`qypkg list` 列出所有已装包与说明；`qypkg -Qi <包名>` 看单个包详情；`qypkg why <包名>` 查是谁的依赖。

## 三、校验 / 更新
- 附件 sha256 与 `index.json` 中该包 `sha256` 一致：`sha256sum <包>.qyp`。
- 每次主仓库出新包，本仓库 Release `latest` 滚动更新（同名附件替换），`curl -LO` 直接拿最新。

---

## 全部 147 个包一览


（机器可读全清单见 [PACKAGES.txt](PACKAGES.txt)；依赖关系见 index.json；大小为装后占用）


### 语言与工具链

| 包文件 | 版本 | 装后 | 说明 | 依赖 |
|---|---|---|---|---|
| `mo-1.10.0-25.x86_64.qyp` | 1.10.0-25 | 0MB | 墨语言——启元官方系统开发语言（自举编译器 + 标准库 + 工具链） | — |
| `python-3.13.3-1.x86_64.qyp` | 3.13.3-1 | 294MB | Python 语言与运行时 | openssl,zlib,libffi,expat,sqlite,readline,ncurses,xz,gdbm,glibc |
| `perl-5.40.1-1.x86_64.qyp` | 5.40.1-1 | 75MB | Perl 脚本语言（很多构建系统依赖它） | gdbm,zlib,glibc |
| `lua-5.4.7-1.x86_64.qyp` | 5.4.7-1 | 1MB | Lua 脚本语言（vim 等嵌入） | readline,glibc |
| `go-1.24.4-1.x86_64.qyp` | 1.24.4-1 | 241MB | Go 编译工具链（仅构建机使用） | glibc |
| `git-2.49.0-1.x86_64.qyp` | 2.49.0-1 | 664MB | 分布式版本控制系统 | curl,openssl,zlib,expat,pcre2,glibc |
| `busybox-1.36.1-1.x86_64.qyp` | 1.36.1-1 | 2MB | 静态多合一 Unix 工具箱 | — |
| `coreutils-9.6-1.x86_64.qyp` | 9.6-1 | 19MB | 基础文件/文本/shell 工具集（ls cp mv 等） | glibc,openssl |
| `util-linux-2.41-1.x86_64.qyp` | 2.41-1 | 22MB | 系统杂项工具（mount lsblk fdisk 等） | zlib,ncurses,glibc,libudev |
| `kmod-34.1-1.x86_64.qyp` | 34.1-1 | 0MB | 内核模块加载与管理 | openssl,zlib,xz,zstd,glibc |
| `shadow-4.17.4-1.x86_64.qyp` | 4.17.4-1 | 4MB | 账户与口令管理（useradd passwd） | glibc |
| `man-db-2.13.1-1.x86_64.qyp` | 2.13.1-1 | 2MB | manual 页数据库与 man 命令 | zlib,gdbm,libpipeline,glibc |
| `cronie-1.7.2-1.x86_64.qyp` | 1.7.2-1 | 0MB | cron 定时任务守护进程 | pam,glibc |
| `rsync-3.4.1-1.x86_64.qyp` | 3.4.1-1 | 0MB | 远程与本地文件的快速增量同步 | zlib,openssl,glibc |
| `wget-1.25.0-1.x86_64.qyp` | 1.25.0-1 | 0MB | 命令行网络下载工具 | openssl,zlib,glibc,pcre2 |
| `curl-8.13.0-1.x86_64.qyp` | 8.13.0-1 | 2MB | 命令行数据传输工具与 libcurl | openssl,zlib,zstd,glibc |
| `ncurses-6.5-1.x86_64.qyp` | 6.5-1 | 6MB | 终端处理库（供 bash、less、vi 等使用） | glibc |
| `readline-8.2-1.x86_64.qyp` | 8.2-1 | 1MB | 命令行行编辑与历史库 | ncurses,glibc |
| `libffi-3.4.7-1.x86_64.qyp` | 3.4.7-1 | 0MB | 外部函数接口库（解释器与 JIT 依赖） | glibc |
| `expat-2.7.0-1.x86_64.qyp` | 2.7.0-1 | 0MB | 流式 XML 解析库 | glibc |
| `gdbm-1.25-1.x86_64.qyp` | 1.25-1 | 0MB | GNU 数据库例程库 | readline,glibc |
| `sqlite-3.49.2-1.x86_64.qyp` | 3.49.2-1 | 3MB | 嵌入式关系型数据库引擎 | zlib,readline,glibc |
| `xz-5.8.1-1.x86_64.qyp` | 5.8.1-1 | 2MB | XZ / LZMA 压缩工具与库 | glibc |
| `zstd-1.5.7-1.x86_64.qyp` | 1.5.7-1 | 3MB | Zstandard 实时压缩算法与库 | zlib,glibc,xz |
| `zlib-1.3.1-1.x86_64.qyp` | 1.3.1-1 | 0MB | 通用无损数据压缩库 | glibc |
| `brotli-1.1.0-1.x86_64.qyp` | 1.1.0-1 | 0MB | Brotli 压缩算法 | glibc |
| `pcre2-10.45-1.x86_64.qyp` | 10.45-1 | 4MB | Perl 兼容正则表达式库 | glibc |
| `json-c-0.18-1.x86_64.qyp` | 0.18-1 | 0MB | JSON 解析库 | glibc |
| `icu-77.1-1.x86_64.qyp` | 77.1-1 | 43MB | Unicode 与国际化组件库 | glibc |
| `libxml2-2.14.3-1.x86_64.qyp` | 2.14.3-1 | 4MB | XML 解析与处理库 | zlib,xz,glibc |
| `libxslt-1.1.43-1.x86_64.qyp` | 1.1.43-1 | 1MB | XSLT 转换库 | libxml2,glibc |
| `nghttp2-1.65.0-1.x86_64.qyp` | 1.65.0-1 | 0MB | HTTP/2 协议库 | openssl,zlib,libev,glibc |
| `libpsl-0.21.5-1.x86_64.qyp` | 0.21.5-1 | 0MB | 公共后缀列表（PSL）解析库 | icu,glibc |
| `popt-1.19-1.x86_64.qyp` | 1.19-1 | 0MB | getopt(3) 的增强版参数解析库 | glibc |
| `logrotate-3.22.0-1.x86_64.qyp` | 3.22.0-1 | 0MB | 日志文件轮转、压缩与删除 | popt,glibc |


### 基础系统

| 包文件 | 版本 | 装后 | 说明 | 依赖 |
|---|---|---|---|---|
| `filesystem-0.2.0-1.x86_64.qyp` | 0.2.0-1 | 0MB | FHS 目录结构、/usr 合并布局与基础 /etc | — |
| `base-config-0.1.0-1.x86_64.qyp` | 0.1.0-1 | 0MB | 基础系统配置（主机名/hosts/profile 等） | busybox,util-linux |
| `glibc-2.42-1.x86_64.qyp` | 2.42-1 | 48MB | GNU C 库 | linux-headers |
| `linux-headers-6.16.1-1.x86_64.qyp` | 6.16.1-1 | 6MB | Linux 内核用户空间头文件 | — |
| `libudev-3.2.14-1.x86_64.qyp` | 3.2.14-1 | 9MB | 设备枚举与监控库（eudev 实现） | glibc |
| `usbutils-018-1.x86_64.qyp` | 018-1 | 0MB | USB 总线诊断工具（lsusb）与 USB ID 库 | glibc,libudev,zlib,libusb |
| `pciutils-3.14.0-1.x86_64.qyp` | 3.14.0-1 | 0MB | PCI 总线诊断工具（lspci/setpci）与 PCI ID 库 | glibc,zlib,libudev |
| `hwdata-0.392-1.x86_64.qyp` | 0.392-1 | 1MB | 硬件标识数据库（pnp.ids 等，纯数据） | — |
| `linux-firmware-20250613-1.x86_64.qyp` | 20250613-1 | 1237MB | 网卡/无线/显卡/存储控制器固件 | — |
| `kernel-6.16.1-1.x86_64.qyp` | 6.16.1-1 | 104MB | Linux 内核（启元基线配置） | — |
| `pam-1.7.0-1.x86_64.qyp` | 1.7.0-1 | 1MB | 可插拔认证模块（PAM） | gdbm,glibc |
| `qyinit-0.1.0-1.x86_64.qyp` | 0.1.0-1 | 0MB | 启元 Linux 初始化与服务管理（PID 1） | — |
| `libpipeline-1.5.8-1.x86_64.qyp` | 1.5.8-1 | 0MB | 子进程管道管理库（man-db 依赖） | glibc |
| `libev-4.33-1.x86_64.qyp` | 4.33-1 | 0MB | 事件循环库 | glibc |


### 图形/桌面

| 包文件 | 版本 | 装后 | 说明 | 依赖 |
|---|---|---|---|---|
| `cairo-1.18.4-1.x86_64.qyp` | 1.18.4-1 | 7MB | 2D 矢量图形库 | pixman,freetype,fontconfig,libpng,zlib,glib |
| `fltk-1.3.9-1.x86_64.qyp` | 1.3.9-1 | 6MB | 轻量 C++ GUI 工具包 | libX11,libXext,libXft,libXrender,libXcursor,libXfixes,libXinerama,libXrandr,fontconfig,freetype,libpng,zlib,jpeg-turbo,glibc |
| `atk-2.38.0-1.x86_64.qyp` | 2.38.0-1 | 2MB | 无障碍工具包（GTK3 依赖） | glib |
| `adwaita-icon-theme-48.0-1.x86_64.qyp` | 48.0-1 | 12MB | GNOME 默认图标集 | hicolor-icon-theme |
| `hicolor-icon-theme-0.18-1.x86_64.qyp` | 0.18-1 | 0MB | 图标主题目录规范骨架 | — |
| `libxkbcommon-1.8.1-1.x86_64.qyp` | 1.8.1-1 | 1MB | 键盘映射处理库（Wayland 与 X11 共用） | xorgproto,libxcb,libX11,wayland,wayland-protocols,libxml2 |
| `wayland-1.23.1-1.x86_64.qyp` | 1.23.1-1 | 1MB | Wayland 显示协议与库 | libffi,expat,libxml2 |
| `wayland-protocols-1.44-1.x86_64.qyp` | 1.44-1 | 0MB | Wayland 标准协议扩展集合 | — |
| `weston-14.0.2-1.x86_64.qyp` | 14.0.2-1 | 10MB | Wayland 参考合成器 | wayland,libxkbcommon,cairo,jpeg-turbo,pango,libdrm,mesa,seatd,libinput,dbus,pixman,libudev |
| `xorg-server-21.1.16-1.x86_64.qyp` | 21.1.16-1 | 41MB | X.org 显示服务器 | libxcvt,libpciaccess,pixman,mesa,libXfont2,libxkbfile,libxshmfence,libdrm,libudev,libinput,dbus |
| `xorgproto-2024.1-1.x86_64.qyp` | 2024.1-1 | 3MB | X11 协议头文件（所有 X 客户端的编译前提） | — |
| `xorg-macros-1.20.2-1.x86_64.qyp` | 1.20.2-1 | 0MB | X.Org 公共 m4/pkgconfig 宏 | — |
| `xtrans-1.6.0-1.x86_64.qyp` | 1.6.0-1 | 0MB | X 传输层库 | xorg-macros |
| `xcb-proto-1.17.0-1.x86_64.qyp` | 1.17.0-1 | 1MB | XCB 协议描述（生成绑定代码用） | — |
| `xextproto-7.3.0-1.x86_64.qyp` | 7.3.0-1 | 0MB | X11 扩展协议头文件 | xorgproto |
| `xineramaproto-1.2.1-1.x86_64.qyp` | 1.2.1-1 | 0MB | X 多屏协议头文件 | xorgproto |
| `renderproto-0.11.1-1.x86_64.qyp` | 0.11.1-1 | 0MB | X 渲染协议头文件 | xorgproto |
| `damageproto-1.2.1-1.x86_64.qyp` | 1.2.1-1 | 0MB | X 损坏协议头文件 | xorgproto |
| `fixesproto-5.0-1.x86_64.qyp` | 5.0-1 | 0MB | X 修正协议头文件 | xorgproto |
| `compositeproto-0.4.2-1.x86_64.qyp` | 0.4.2-1 | 0MB | X 合成协议头文件 | xorgproto |
| `inputproto-2.3.2-1.x86_64.qyp` | 2.3.2-1 | 0MB | X11 输入扩展协议头文件 | xorgproto |
| `randrproto-1.5.0-1.x86_64.qyp` | 1.5.0-1 | 0MB | X RandR 协议头文件 | xorgproto |
| `fontconfig-2.16.0-1.x86_64.qyp` | 2.16.0-1 | 1MB | 字体配置与匹配库 | freetype,expat,libxml2 |
| `freetype-2.13.3-1.x86_64.qyp` | 2.13.3-1 | 1MB | 字体渲染引擎 | zlib,libpng,brotli,glibc |
| `fribidi-1.0.16-1.x86_64.qyp` | 1.0.16-1 | 0MB | 双向文本算法实现 | — |
| `gdk-pixbuf-2.42.12-1.x86_64.qyp` | 2.42.12-1 | 3MB | 图像加载库（GTK3 依赖） | glib,libpng,jpeg-turbo |
| `giflib-5.2.2-1.x86_64.qyp` | 5.2.2-1 | 0MB | GIF 图像格式库 | glibc |
| `shared-mime-info-2.4-2.x86_64.qyp` | 2.4-2 | 7MB | 共享 MIME 类型数据库 | glib,libxml2 |
| `desktop-file-utils-0.28-1.x86_64.qyp` | 0.28-1 | 0MB | desktop 文件工具（update-desktop-database） | glib |
| `desktop-env-1.0.0-1.x86_64.qyp` | 1.0.0-1 | 0MB | 桌面环境元包（拉齐桌面全套组件） | gui-base,alsa-lib,pipewire,dbus,polkit,desktop-file-utils,shared-mime-info,xorg-server |
| `desktop-shell-0.1.0-1.x86_64.qyp` | 0.1.0-1 | 0MB | 启元自研桌面壳（qydesktop 面板/壁纸/启动器） | gtk3,polkit,dbus,networkmanager,alsa-lib |
| `gui-base-1.0.0-1.x86_64.qyp` | 1.0.0-1 | 0MB | GUI 基础元包（Wayland/X 协议与基础库） | mesa,libxkbcommon,libinput,gtk3,fontconfig,freetype,harfbuzz,cairo,pango,gdk-pixbuf,hicolor-icon-theme,adwaita-icon-theme,dbus |
| `seatd-0.9.1-1.x86_64.qyp` | 0.9.1-1 | 0MB | 最小化 seat 与会话管理守护进程 | — |
| `polkit-126-1.x86_64.qyp` | 126-1 | 0MB | 特权操作授权框架 | glib,dbus,pam |
| `pixman-0.46.2-1.x86_64.qyp` | 0.46.2-1 | 5MB | 像素操作库（cairo 与 X 服务器依赖） | — |
| `libpng-1.6.47-1.x86_64.qyp` | 1.6.47-1 | 0MB | PNG 图像格式库 | zlib,glibc |
| `jpeg-turbo-3.1.0-1.x86_64.qyp` | 3.1.0-1 | 2MB | JPEG 编解码库（SIMD 加速） | — |
| `libtiff-4.7.0-1.x86_64.qyp` | 4.7.0-1 | 6MB | TIFF 图像格式库 | jpeg-turbo,zlib,xz,glibc,zstd |
| `libwebp-1.5.0-1.x86_64.qyp` | 1.5.0-1 | 1MB | WebP 图像格式库 | libpng,jpeg-turbo,libtiff,giflib,glibc |
| `libdrm-2.4.124-1.x86_64.qyp` | 2.4.124-1 | 1MB | DRM 内核接口封装库 | — |
| `mesa-24.0.9-1.x86_64.qyp` | 24.0.9-1 | 169MB | 开源 OpenGL / Vulkan 实现 | libdrm,libxcb,libX11,libXext,libXdamage,libXfixes,libxkbcommon,wayland,zlib,zstd,expat,libelf,libxshmfence,libXxf86vm,libXrender,libXrandr |
| `pango-1.56.3-1.x86_64.qyp` | 1.56.3-1 | 4MB | 文本布局与渲染库 | glib,cairo,harfbuzz,fribidi,freetype,fontconfig |
| `harfbuzz-10.3.0-1.x86_64.qyp` | 10.3.0-1 | 62MB | 文字塑形引擎（复杂文本排版） | freetype,glib,glibc |
| `glib-2.84.0-1.x86_64.qyp` | 2.84.0-1 | 43MB | 通用工具与对象库（GTK 与大量应用的基础） | libffi,pcre2,zlib,libxml2,util-linux,glibc,libelf |
| `dbus-1.16.2-1.x86_64.qyp` | 1.16.2-1 | 3MB | 进程间消息总线（桌面与系统服务通信基础） | expat,glibc |
| `gtk3-3.24.43-1.x86_64.qyp` | 3.24.43-1 | 76MB | GTK 3 图形界面工具包 | glib,pango,atk,gdk-pixbuf,cairo,libX11,libXext,libXinerama,libXi,libXrandr,libXcursor,libXdamage,libXcomposite,wayland,libepoxy,harfbuzz,fribidi,iso-codes |
| `libX11-1.8.12-1.x86_64.qyp` | 1.8.12-1 | 13MB | X11 客户端核心库 | xorgproto,libxcb,libXau,libXdmcp,xtrans,glibc |
| `libXau-1.0.12-1.x86_64.qyp` | 1.0.12-1 | 0MB | X 授权库 | xorgproto,glibc |
| `libXcomposite-0.4.6-1.x86_64.qyp` | 0.4.6-1 | 0MB | X 合成扩展库 | libX11,libXfixes,compositeproto |
| `libXcursor-1.2.3-1.x86_64.qyp` | 1.2.3-1 | 0MB | X 光标管理库 | libX11,libXrender,libXfixes |
| `libXdamage-1.1.6-1.x86_64.qyp` | 1.1.6-1 | 0MB | X 损坏区域扩展库 | libX11,libXfixes,damageproto |
| `libXdmcp-1.1.5-1.x86_64.qyp` | 1.1.5-1 | 0MB | X 显示管理器控制协议库 | xorgproto,glibc |
| `libXext-1.3.6-1.x86_64.qyp` | 1.3.6-1 | 0MB | X11 扩展库 | libX11,xextproto,glibc |
| `libXfixes-6.0.1-1.x86_64.qyp` | 6.0.1-1 | 0MB | X 修正扩展库 | libX11,fixesproto |
| `libXfont2-2.0.7-1.x86_64.qyp` | 2.0.7-1 | 0MB | X 服务器字体库 | freetype,fontconfig,libfontenc,xorgproto,xtrans,zlib |
| `libXft-2.3.8-1.x86_64.qyp` | 2.3.8-1 | 0MB | X 字体渲染库（FreeType 与 X 的桥接） | libX11,libXrender,freetype,fontconfig,glibc |
| `libXi-1.8.2-1.x86_64.qyp` | 1.8.2-1 | 0MB | X 输入扩展库 | libX11,libXext,inputproto |
| `libXinerama-1.1.5-1.x86_64.qyp` | 1.1.5-1 | 0MB | X 多屏扩展库 | libX11,libXext,xineramaproto |
| `libXrandr-1.5.4-1.x86_64.qyp` | 1.5.4-1 | 0MB | X 屏幕分辨率与旋转扩展库 | libX11,libXext,libXrender,randrproto |
| `libXrender-0.9.12-1.x86_64.qyp` | 0.9.12-1 | 0MB | X 渲染扩展库 | libX11,renderproto |
| `libXxf86vm-1.1.6-1.x86_64.qyp` | 1.1.6-1 | 0MB | XFree86-VidMode 扩展库 | libX11,libXext,xorgproto,glibc |
| `libxcb-1.17.0-1.x86_64.qyp` | 1.17.0-1 | 6MB | X C 语言绑定库 | xorgproto,libXau,libXdmcp,xcb-proto,glibc |
| `libxcvt-0.1.2-1.x86_64.qyp` | 0.1.2-1 | 0MB | VESA CVT 标准模型计算库 | — |
| `libxkbfile-1.1.3-1.x86_64.qyp` | 1.1.3-1 | 0MB | 键盘描述文件解析库 | libX11 |
| `libxshmfence-1.3.3-1.x86_64.qyp` | 1.3.3-1 | 0MB | 共享内存同步原语（X 的 GLX 用） | xorgproto |
| `libepoxy-1.5.10-1.x86_64.qyp` | 1.5.10-1 | 6MB | OpenGL 函数指针管理库 | mesa |
| `libfontenc-1.1.8-1.x86_64.qyp` | 1.1.8-1 | 0MB | X 字体编码库 | zlib |
| `libevdev-1.13.1-1.x86_64.qyp` | 1.13.1-1 | 0MB | 输入事件设备封装库 | — |
| `libinput-1.28.0-1.x86_64.qyp` | 1.28.0-1 | 4MB | 输入设备处理库 | libevdev,mtdev,libudev |
| `mtdev-1.1.6-1.x86_64.qyp` | 1.1.6-1 | 0MB | 多点触控协议转换库 | — |
| `libpciaccess-0.18.1-1.x86_64.qyp` | 0.18.1-1 | 0MB | PCI 设备访问库 | zlib |


### 网络

| 包文件 | 版本 | 装后 | 说明 | 依赖 |
|---|---|---|---|---|
| `bluez-5.82-1.x86_64.qyp` | 5.82-1 | 4MB | 蓝牙协议栈 | dbus,glib,readline,libudev,glibc |
| `iwd-3.9-1.x86_64.qyp` | 3.9-1 | 3MB | 内核原生无线守护（iNet Wireless Daemon） | glibc,readline |
| `ell-0.76-1.x86_64.qyp` | 0.76-1 | 0MB | 嵌入式 Linux 基础库（iwd 依赖） | glibc |
| `frp-0.61.2-1.x86_64.qyp` | 0.61.2-1 | 32MB | 内网穿透反向代理（frpc 客户端 + frps 服务端） | — |
| `rathole-0.5.0-1.x86_64.qyp` | 0.5.0-1 | 4MB | Rust 高性能内网穿透（轻量，路由器/树莓派友好） | glibc,openssl |
| `openssl-3.5.0-1.x86_64.qyp` | 3.5.0-1 | 24MB | TLS/SSL 与通用密码学库 | zlib,glibc |
| `openssh-10.0p2-1.x86_64.qyp` | 10.0p2-1 | 7MB | SSH 客户端与服务端 | openssl,zlib,glibc |
| `networkmanager-1.52.0-1.x86_64.qyp` | 1.52.0-1 | 51MB | 网络连接管理服务 | libndp,libnl,dbus,glib,libudev,curl,readline,openssl |
| `libnl-3.11-1.x86_64.qyp` | 3.11-1 | 2MB | netlink 协议库（内核网络栈通信） | glibc |
| `libndp-1.9-1.x86_64.qyp` | 1.9-1 | 0MB | IPv6 邻居发现协议库 | glibc |
| `libsoup-3.6.5-1.x86_64.qyp` | 3.6.5-1 | 3MB | HTTP 客户端库（GNOME 生态） | glib,libxml2,sqlite,openssl,nghttp2,brotli,libpsl,glibc,zlib |


### 多媒体

| 包文件 | 版本 | 装后 | 说明 | 依赖 |
|---|---|---|---|---|
| `alsa-lib-1.2.14-1.x86_64.qyp` | 1.2.14-1 | 2MB | ALSA 声音库 | — |
| `flac-1.5.0-1.x86_64.qyp` | 1.5.0-1 | 1MB | 无损音频编解码器 | libogg |
| `pipewire-1.4.1-1.x86_64.qyp` | 1.4.1-1 | 41MB | 音视频路由守护（PipeWire） | alsa-lib,glib,libudev,libsndfile,dbus,ncurses |
| `libogg-1.3.5-1.x86_64.qyp` | 1.3.5-1 | 0MB | Ogg 容器格式库 | — |
| `libvorbis-1.3.7-1.x86_64.qyp` | 1.3.7-1 | 1MB | Vorbis 音频编解码库 | libogg |
| `opus-1.5.2-1.x86_64.qyp` | 1.5.2-1 | 0MB | Opus 音频编解码库 | — |
| `libsndfile-1.2.2-1.x86_64.qyp` | 1.2.2-1 | 1MB | 音频文件读写库 | libsamplerate,flac,libogg,libvorbis,opus |
| `libsamplerate-0.2.2-1.x86_64.qyp` | 0.2.2-1 | 1MB | 采样率转换库 | — |
| `libical-3.0.20-1.x86_64.qyp` | 3.0.20-1 | 2MB | iCalendar 协议解析库 | glib,glibc,libxml2 |
| `libusb-1.0.28-1.x86_64.qyp` | 1.0.28-1 | 0MB | 用户态 USB 设备访问 | glibc,libudev |


### 演示/杂项

| 包文件 | 版本 | 装后 | 说明 | 依赖 |
|---|---|---|---|---|
| `libqydemo-0.2.0-1.x86_64.qyp` | 0.2.0-1 | 0MB | 启元构建系统演示共享库 | — |
| `qydemo-0.2.0-1.x86_64.qyp` | 0.2.0-1 | 0MB | 端到端链路验证演示程序 | libqydemo |
| `qydesktop-0.1.0-7.x86_64.qyp` | 0.1.0-7 | 0MB | 启元桌面面板与启动器 | gtk3,glib,cairo |
| `dillo-3.2.0-1.x86_64.qyp` | 3.2.0-1 | 2MB | 极轻量浏览器（自研引擎，约 1MB） | zlib,libpng,openssl,glib,glibc,jpeg-turbo |


### 其他

| 包文件 | 版本 | 装后 | 说明 | 依赖 |
|---|---|---|---|---|
| `iso-codes-4.17.0-1.x86_64.qyp` | 4.17.0-1 | 20MB | ISO 标准代码数据集（语言/国家/货币名） | — |
| `libelf-0.192-1.x86_64.qyp` | 0.192-1 | 7MB | ELF 文件读写库（elfutils 的一部分） | zlib,zstd,xz |
