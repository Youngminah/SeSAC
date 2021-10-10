</br>
</br>

## 전체 정리
- 신조어 부터 각각의 주제별로 브랜치에 나눠서 관리 예정
- 바뀐 내용 `commit message` 참고

| 주제                   | 리팩토링           | 마지막 업데이트                     |  뷰 구현 방식    |  
| --------------------- | ---------------- | ---------------------------     | ------------- |  
| 전광판                  |                  |  **2021.10.05**                 |   Custom Code |  
| 신조어                  |  ✔️               |  **2021.10.07**                 |   Custom Code |     
| 기념일계산기              |                 |  **2021.10.07**                 |   Custom Code |  
| 물마시기                |     ✔️            |  **2021.10.10**                  |   StoryBoard |  
</br>
</br>

## 이전 과제

<details><summary>전광판</summary>
   
## 전광판
![ 전광판 mp4](https://user-images.githubusercontent.com/42762236/136308780-01a8ac9e-63a2-41d9-ae60-8d1e247ae86a.gif)

</br>
</br>
</br>
</br>
</details>

<details><summary>신조어</summary>
   
## 신조어
![신조어 mp4](https://user-images.githubusercontent.com/42762236/136308787-7e6ab252-56e1-4504-9ec2-09ee2ebfba3e.gif)

</br>
</br>
</br>
</br>
</details>

<details><summary>기념일 계산기</summary>

# 기념일 계산기
![Simulator Screen Recording - iPhone 11 - 2021-10-07 at 20 14 37](https://user-images.githubusercontent.com/42762236/136373797-534db939-0c62-4608-a154-64df7299cade.gif)

</br>
</br>
</br>
</br>
</details>
</br>
</br>
   
## 물 마시기

https://user-images.githubusercontent.com/42762236/136702716-5224904e-430a-4e8e-960c-63e21bd96021.mp4
- 스토리보드. 오토레이아웃 `아이폰 SE2 ~ 아이폰13` 확인 완료
- 오토레이아웃 제외 모든 속성 코드 구현
- 사용한 라이브러리: `Texteffects`
- keyboard 따른 높이 뷰 조정
- 앱 종료 후 데이터 저장
- 유저 interaction 이후 알람창
- 물의 양에 따른 식물 변화
- 프로필 수정후 이전화면 반영
- 유저 정보 없을시 프로필 버튼만 누를수 있도록 구성과 안내화면 셋팅
- 기본적인 텍스트 벨리데이션
- 애니메이션
</br>

### ✔️ 주어진 조건 이외에 깊게 생각 해볼 만한 이슈 사항
- 키보드에 따른 뷰 위치 조정 
   - (텍스트필드와 키보드 위치가 절묘하게 겹친 것을 봐선 의도된 부분 같음)
   - 라이브러리로 조정을 하려했는데 가장 최근 버전에서 특정부분 오류가 있어서 제거


- 프로필 수정 후 이전 화면 반영
   - 메인화면 뷰 컨트롤러 viewWillAppear에 UI를 업데이트해주면 해결이 되긴 하는데, 최선인가? 생각해 볼 필요가 있음
   - 프로필화면에서 수정은 안하고 늘락날락 거릴경우 쓸 데없는 호출이 일어남 
   - 프로필에서 `저장`버튼을 눌렀을 때만 UI업뎃을 해주는 것이 좋을듯 
</br>

### ✔️ 구현하고보니 구현하면 좋을 사항
- 메인화면에서 키보드가 올라올 때 물 마시기 버튼도 같이 붙어서 올라오게 할 껄 그랬다..!



</br>
</br>
</br>
</br>
