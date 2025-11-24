# 📋 Flutter Todo App
> 간단한 Todo기능을 수행하는 애플리케이션입니다
<br>

## 🛠️ 기술 스택
- Fluuter
- Riverpod
- Drift(SQLite DB)
- 개발 환경 :  iOS Simulator

## 🚀 실행가이드
#### 👉 저장소 복사
  ```
  https://github.com/LifeIsOne/flutter-todo-app
  ```
#### 👉 저장소 이동
  ```
  cd todo_app
  ```


#### 👉 의존성 설치
  ```
  flutter pub get
  ```  
  
  ﾠﾠAndroidSutdio IDE의 `pubsepcyaml`파일에서 'Pub get'
ﾠ

#### 👉 Drift 코드 생성
  ```
  dart run build_runner build
  ```


#### 👉 앱 실행
```
flutter run
```



## 💁‍♂️프로젝트 설명
### 프로젝트 기능 설명
- CRUD
- 사진, 태그, 마감일 등록
- 태그, 검색어 필터
  
### 프로젝트 설계 시 고민했던 점
    
  Todo와 Tag 목록, 필터(Tag와 검색어)등 상태가 늘어가면서 `setState`로 관리하는 것이 복잡했다. 나중에 Riverpod으로 전환하게 되어 전역에서 상태를 공유를 했고, 상태를 관리하게 되어 확장과 재사용성을 높혔다. 원래는 기존에 하던 REST API와 MySQL 서버로 구성해 MVVC 패턴을 적용하려고 했지만 알바, 팀 프로젝트, 개인 일정 등으로 시간이 부족할 것 같았고, 새로운 기술을 사용해보고 싶은 욕심도 있어 Drift 기반을 사용했다.
