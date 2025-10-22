## 초기 세팅
- dart pub global activate melos
- flutter pub run melos bs

## 의존 관계
- flutter pub run melos list --graph

패키지(모듈)간의 의존 관계(종속성)을 시각적으로 볼 수 있는 명령어

- 현재 의존 관계
```
{
  "core_test": [],
  "feature_test": [
    "core_test",
    "shared_test"
  ],
  "project_name": [
    "core_test",
    "shared_test",
    "feature_test"
  ],
  "shared_test": []
}
```

## 패키지 추가
- flutter create --template=package {packageName}


## build_runner
- flutter pub run build_runner build --delete-conflicting-outputs


## 참고
- fvm 을 쓰는 경우 명령어 앞에 `fvm` 추가
