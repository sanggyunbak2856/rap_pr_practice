#!/usr/bin/env bash
set -euo pipefail

# 루트 폴더 이름 (원하면 변경)
ROOT="ZPRPRAC_B11"

# 디렉터리 구조 정의 (상대경로)
dirs=(
  "$ROOT/Business Services"
  "$ROOT/Business Services/Service Bindings"
  "$ROOT/Business Services/Service Definitions"

  "$ROOT/Core Data Services"
  "$ROOT/Core Data Services/Access Controls"
  "$ROOT/Core Data Services/Behavior Definitions"
  "$ROOT/Core Data Services/Data Definitions"
  "$ROOT/Core Data Services/Metadata Extensions"

  "$ROOT/Dictionary"
  "$ROOT/Dictionary/Data Elements"
  "$ROOT/Dictionary/Database Tables"
  "$ROOT/Dictionary/Domains"

  "$ROOT/Source Code Library"
  "$ROOT/Source Code Library/Classes"
)

# 생성
echo "Creating folder structure under: $ROOT"
for d in "${dirs[@]}"; do
  mkdir -p "$d"
  # 숨김 파일 대신 .gitkeep을 생성하면 빈 디렉터리도 버전관리 가능
  touch "$d/.gitkeep"
done

# 구조 출력 (find 사용)
echo
echo "Created directories:"
find "$ROOT" -type d | sed "s#^# - #"

echo
echo "Done."
