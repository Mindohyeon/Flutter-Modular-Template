## 참고 
`fvm` 을 쓰는 경우로 가정해 만든 템플릿입니다

## 초기 세팅
- chmod +x create_project.sh
  > create_project.sh 실행 권한 부여
- ./create_project.sh
  > 스크립트 실행 <br>
  >  원하는 프로젝트명과 플랫폼을 선택 (스페이스 바로 선택)
- fvm dart pub global activate melos
- fvm flutter pub run melos bs
  > 각 패키지의 의존성을 설치하고 링크 연결
  
<br>
project_name 패키지와 각 feature,core,shared에 test 모듈은 제거해도 무방함

## 의존 관계
- fvm flutter pub run melos list --graph

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

## 패키지(모듈) 추가
- fvm flutter create --template=package {packageName}


## build_runner
- fvm flutter pub run build_runner build --delete-conflicting-outputs
