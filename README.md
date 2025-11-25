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
    
  Todo와 Tag 목록, 필터(Tag와 검색어)등 상태가 늘어가면서 `setState`로 관리하는 것이 복잡해 어려웠다. UI 틀을 만든 후, Riverpod으로 구조를 전환해 전역에서 상태를 공유하고 관리했다. 재사용성도 단번에 좋아져 많이 단순해지는 걸 체감할 수 있었다.
  원래는 기존에 하던 방식대로 REST API와 MySQL 서버로 구성해 MVVC 패턴을 적용하려 했지만 일정상 시간이 부족할 것 같았고, 새로운 기술을 실전에 적용해보고 싶은 욕심도 있어 Drift 기반을 사용했다. 다른 언어를 공부하는 중이라 Flutter에 대한 부족함을 느꼈지만, 필요한 자료와 이전 프로젝트의 소스를 찾아보며 요구사항을 해결하는 과정에서 제법 큰 성취감을 얻었다.
  
<br><br>

<h1 align='center'>💃감사합니다!🕺</h1>
