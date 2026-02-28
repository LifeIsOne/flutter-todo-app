# 📋 Flutter Todo App

> 간단한 Todo기능을 수행하는 애플리케이션입니다

<br>

## 🛠️ 기술 스택

- Fluter
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

- `setStat()`를 Riverpod으로 전환하며 페이지 단위 상태관리를 위해 MVVM패턴을 적용하는 데에 어려웠지만, 단순해지는 것을 보며 많이 배울 수 있었다.
- TodoCreateScreen과 TodoEditScreen을 TodoFormScreen하나로 통합하는데에 많은 고민을 했고, 덕분에 많은 공부가 됐다
- Dart Lints를 알게되어 이전의 문법과 부족한 문법을 고칠 수 있게 되어 개발자로써 한 단계 성장할 수 있었다.

<br><br>

<h1 align='center'>💃감사합니다!🕺</h1>
