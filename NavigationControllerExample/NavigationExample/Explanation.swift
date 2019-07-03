/*

 Navigation Controller
 
 present modally 와 show
 present motally 덮어쓰는 (아래에서 뷰가 위로 올라오는게 기본 애니메이션)
 show 로 하면 내비게이션 스택에 쌓이는 방식 ( 화면이 오른쪽으로 이동하는 애니메이션 )\
    - push , pop 이라고 표현
 
 내비게이션 컨트롤러는 뷰 컨트롤러의 관리자를 둔다고 생각하면 될듯
 
 
 내비게이션 컨트롤러를 코드로 구현
1. 첫번쨰 뷰로 설정하기
    AppDelegate 에서 첫화면을 설정해줘야함.
 
 2. AppDelegate 에서
 navigation controller 객체 생성하고 root 설정하기
 
 3. first , second controller 에서 나머지 설정

 */
