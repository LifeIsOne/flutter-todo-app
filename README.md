# 📋 Flutter Todo App
> 간단한 Todo기능을 수행하는 애플리케이션입니다

<br>

## 🛠️ 기술 스택
- Fluuter
- Riverpod
- Drift(SQLite DB)
- 개발 환경 :  iOS Simulator

<br>

## 🚀 실행가이드
#### 👉 저장소 복사
  ```
  https://github.com/LifeIsOne/flutter-todo-app
  ```
#### 👉 저장소 이동
  ```
  cd todo_app
  ```
<br>

#### 👉 의존성 설치
  ```
  flutter pub get
  ```  

  ﾠﾠAndroidSutdio IDE의 `pubsepcyaml`파일에서 'Pub get'
<br>ﾠ

#### 👉 Drift 코드 생성
  ```
  dart run build_runner build
  ```
<br>

#### 👉 앱 실행

```
  flutter run
```

<br><br>

## 💁‍♂️ 프로젝트 설명
### 🎥 시연 영상
#### 📌 앱 실행, 사용자 정보 변경, Todo 작성
![시연1](https://github.com/user-attachments/assets/61afa270-7f01-4ceb-bc04-a858f1e4b7d1)

#### 📌 수정하기, 필터, 검색, 삭제하기
![수정하기, 필터, 검색, 삭제하기](https://github.com/user-attachments/assets/30da05e9-7be4-43ab-8806-836e21b66e1c)

#### 📌 임시저장
![임시저장](https://github.com/user-attachments/assets/0f1144aa-0c34-4b6f-865b-a24ec335d0cc)

  
### 🙋‍♂️ 프로젝트 설계 시 고민했던 점
    
  Todo와 Tag 목록, 필터(Tag와 검색어)등 상태가 늘어가면서 `setState`로 관리하는 것이 복잡했다. 나중에 Riverpod으로 전환하게 되어 전역에서 상태를 공유를 했고, 상태를 관리하게 되어 확장과 재사용성을 높혔다. 원래는 기존에 하던 REST API와 MySQL 서버로 구성해 MVVC 패턴을 적용하려고 했지만 일정으로 시간이 부족할 것 같았고, 새로운 기술을 사용해보고 싶은 욕심도 있어 Drift 기반을 사용했다. 
  
<br><br>

<h1 align='center'>💃감사합니다!🕺</h1>
