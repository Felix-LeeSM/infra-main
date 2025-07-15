#!/bin/bash
set -e # 스크립트 실행 중 에러가 발생하면 즉시 중단

echo "✅ Step 1: Submodule 초기화 및 동기화 (최초 클론 대응)"
# 이 명령어는 서브모듈이 아직 초기화되지 않은 상태(최초 클론)에서 디렉토리를 설정하고,
# 이미 초기화된 상태에서는 메인 프로젝트에 기록된 커밋으로 업데이트합니다.
# --init: 초기화되지 않은 서브모듈을 설정합니다.
# --recursive: 중첩된 서브모듈까지 모두 처리합니다.
git submodule update --init --recursive

echo "✅ Step 2: 메인 프로젝트 최신 변경사항 PULL"
git pull origin main

echo "✅ Step 3: 각 서브모듈의 최신 변경사항 PULL"
# 메인 프로젝트 pull 이후, 각 서브모듈 디렉토리로 이동하여 최신 내용을 pull 합니다.
# 이 단계는 서브모듈을 메인 프로젝트에 기록된 특정 커밋이 아닌,
# 각자의 원격 브랜치 최신 상태로 만들고 싶을 때 사용합니다.
git submodule foreach '
    echo "--- submodule: $name 업데이트 중 ---"
    # git pull은 현재 브랜치의 최신 내용을 가져옵니다.
    git pull
'

echo "🎉 완료: 메인 프로젝트와 모든 서브모듈이 초기화 및 업데이트되었습니다."
