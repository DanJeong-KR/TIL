





enum Site {
    case google(String, String)
    case kakao(String, String)
    case naver(String, String)
    
    func signIn() {
        switch self {
        case .google(let id, let pass):
            print("구글에 로그인 하셨습니다. (아이디 - \(id) 비밀번호 - \(pass))")
        case .kakao(let id, let pass):
            print("카카오에 로그인 하셨습니다. (아이디 - \(id) 비밀번호 - \(pass))")
        case .naver(let id, let pass):
            print("네이버에 로그인 하셨습니다. (아이디 - \(id) 비밀번호 - \(pass))")
        }
    }
}


let google = Site.google("google@gmail.com", "0000")
google.signIn()






/***************************************************
 1. 시험 시간
 10시 ~ 13시 - Playground 에 작성 후 제출
 13시 ~ 14시 - 점심시간
 14시 ~ 18시 - 작성한 Xcode 프로젝트를 압축하여 제출
 
 2. 제출 방법
 디렉토리 이름을 자신의 이름으로 만들고 그 안에 파일을 넣어 압축하여 슬랙으로 전달
 
 3. 전달사항
 화이팅!
 ***************************************************/




//: [Next](@next)
