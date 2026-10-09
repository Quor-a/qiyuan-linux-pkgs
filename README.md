# 启元 Linux 二进制包仓库 / Qiyuan Linux Binary Packages

全部预编译 `.qyp` 包（147 个）以 **GitHub Release 附件**发布，仓库本体只放 README 与清单，**产物不进 git**。

## 终端下载安装（两种方式）

### 方式一：qypkg 直接装（推荐）
```sh
# 单包：-U 指定 .qyp 文件安装
curl -LO https://github.com/Quor-a/qiyuan-linux-pkgs/releases/latest/download/<包名>.qyp
qypkg -U <包名>.qyp

# 例：装 mo 编译器
curl -LO https://github.com/Quor-a/qiyuan-linux-pkgs/releases/latest/download/mo-1.10.0-24.x86_64.qyp
qypkg -U mo-1.10.0-24.x86_64.qyp
```

### 方式二：配成本地仓库源
```sh
mkdir -p /var/repo/x86_64 && cd /var/repo/x86_64
curl -LO https://github.com/Quor-a/qiyuan-linux-pkgs/releases/latest/download/index.json
# 之后按 index.json 里的清单逐包 curl -LO，再：
qypkg --repo /var/repo --allow-unsigned install <包名>
```

### 全量下载
```sh
curl -LO https://github.com/Quor-a/qiyuan-linux-pkgs/releases/latest/download/PACKAGES.txt
while read p; do curl -LO "https://github.com/Quor-a/qiyuan-linux-pkgs/releases/latest/download/$p"; done < PACKAGES.txt
```

## 包清单
见 `PACKAGES.txt`（名-版本-大小-描述）与 Release 附件区。配方（源码构建脚本）在主仓库 `recipes/`。

## 依赖关系
qypkg 会自动解析依赖（`qypkg install`），也可以 `qypkg why <包>` 查谁依赖它。
