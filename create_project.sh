#!/bin/bash
set -e # 명령어 실패 시 스크립트 종료하도록 설정

# Flutter 프로젝트 이름 입력
read -p "Enter your Flutter project name: " PROJECT_NAME

# 이름 유효성 검사
if [[ -z "$PROJECT_NAME" ]]; then
  echo "❌ Project name cannot be empty."
  exit 1
fi

APP_ROOT="./app"
PROJECT_PATH="$APP_ROOT/$PROJECT_NAME"
# Flutter 버전
FLUTTER_VERSION=$(fvm flutter --version --machine | grep '"frameworkVersion"' | sed -E 's/.*"frameworkVersion": ?"([^"]+)".*/\1/')

# Dart SDK 버전
DART_VERSION=$(fvm flutter --version --machine | grep '"dartSdkVersion"' | sed -E 's/.*"dartSdkVersion": ?"([^"]+)".*/\1/')


# app 폴더가 없으면 생성
if [[ ! -d "$APP_ROOT" ]]; then
  echo "📁 'app' directory not found, creating it now..."
  mkdir -p "$APP_ROOT"
fi

# 플랫폼 선택 (gum)
PLATFORMS=$(gum choose \
  --no-limit \
  --header "Select target platforms (↑ ↓ Space to select, Enter to confirm):" \
  android ios web macos windows linux)

if [[ -z "$PLATFORMS" ]]; then
  gum style --foreground "white" "❌ No platforms selected."
  exit 1
fi

# 프로젝트 생성
echo ""
gum style --foreground "white" "🚀 Creating Flutter project '$PROJECT_NAME' with: ${PLATFORMS//$'\n'/, } ..."
fvm flutter create "$PROJECT_PATH" --project-name "$PROJECT_NAME" --platforms="${PLATFORMS//$'\n'/,}"

# 프로젝트 내부 pubspec.yaml 덮어쓰기 (dependencies 포함)
cat > "$PROJECT_PATH/pubspec.yaml" <<EOF
name: $PROJECT_NAME
description: "A new Flutter package project."
version: 1.0.0+1

environment:
  sdk: ^$DART_VERSION
  flutter: "^$FLUTTER_VERSION"

dependencies:
  flutter:
    sdk: flutter

  core_test:
    path: ../../core/core_test
  shared_test:
    path: ../../shared/shared_test
  feature_test:
    path: ../../feature/feature_test

dev_dependencies:
  build_runner: 2.7.0
  flutter_lints: ^5.0.0
EOF

gum style --foreground "white" "✅ Project pubspec.yaml dependencies updated."

# 루트 pubspec.yaml name 변경 (_workspace 붙이기)
if [[ -f "./pubspec.yaml" ]]; then
  if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i "" "s/^name:.*/name: ${PROJECT_NAME}_workspace/" ./pubspec.yaml
  else
    sed -i "s/^name:.*/name: ${PROJECT_NAME}_workspace/" ./pubspec.yaml
  fi
  gum style --foreground "white" "✅ Root pubspec.yaml name updated to '${PROJECT_NAME}_workspace'"
fi

# 완료 메시지
gum style --border double --margin "1" --padding "1 2" --border-foreground "white" --foreground "white" \
"✅ Flutter project '$PROJECT_NAME' created successfully!

📂 Location: $PROJECT_PATH

🧩 Platforms: ${PLATFORMS//$'\n'/, }"
