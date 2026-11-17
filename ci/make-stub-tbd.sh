#!/bin/bash
# 汇总 roothide SDK 里所有私有框架的 tbd 架构信息, 用于诊断
SDK="${THEOS}/sdks/iPhoneOS16.5.sdk"
FW="$SDK/System/Library/PrivateFrameworks"
for name in "$@"; do
  tbd="$FW/$name.framework/$name.tbd"
  echo "== $tbd"
  ls -l "$tbd" || true
  head -6 "$tbd" || true
done
echo "== all private framework tbd archs =="
for t in "$FW"/*.framework/*.tbd; do printf '%-40s %s\n' "$(basename "$t")" "$(sed -n '2p' "$t")"; done
