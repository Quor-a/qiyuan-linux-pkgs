#!/bin/bash
# 从 Release 下载启元 Linux 的 .qyp 包。用法:
#   bash dl.sh all          全量下载到 ./pkgs
#   bash dl.sh mo python    只下名字里含这些关键词的包
set -u
BASE=https://github.com/Quor-a/qiyuan-linux-pkgs/releases/latest/download
DEST=${DEST:-./pkgs}
mkdir -p "$DEST"
curl -fsSLO --output-dir "$DEST" "$BASE/PACKAGES.txt" 2>/dev/null || curl -fsSL -o "$DEST/PACKAGES.txt" "$BASE/PACKAGES.txt"

want="$*"
[ -z "$want" ] && want="all"
while IFS=$'\t' read -r f ver mb desc; do
  case "$f" in \#*|"") continue;; esac
  if [ "$want" = "all" ]; then ok=1; else ok=0; for w in $want; do case "$f" in *"$w"*) ok=1;; esac; done; fi
  [ "$ok" = 1 ] || continue
  echo "==> $f (${mb}MB)"
  curl -fL --retry 3 -o "$DEST/$f" "$BASE/$f" || echo "  失败: $f"
done < "$DEST/PACKAGES.txt"
echo "完成，包在 $DEST/"
