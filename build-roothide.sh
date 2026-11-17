#!/bin/bash
# VPNNodeSelector 本地 Mac 一键 roothide 编译脚本
# 前提: 已安装"完整版 Xcode"(仅 Command Line Tools 不够)
set -e

if ! xcode-select -p | grep -q "Xcode.app"; then
    echo "错误: 请先安装完整 Xcode 并执行 sudo xcode-select -s /Applications/Xcode.app/Contents/Developer"
    exit 1
fi

# 安装 roothide 版 Theos(已装则自动跳过/更新)
if [ ! -d "$HOME/theos" ] || [ ! -x "$HOME/theos/bin/install-theos" ]; then
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/roothide/theos/master/bin/install-theos)"
fi

export THEOS="$HOME/theos"
make clean
make package THEOS_PACKAGE_SCHEME=roothide ARCHS=arm64e FINALPACKAGE=1

echo
echo "=============================================="
echo "编译完成! deb 在 packages/ 目录:"
ls -la packages/*.deb
echo "=============================================="
