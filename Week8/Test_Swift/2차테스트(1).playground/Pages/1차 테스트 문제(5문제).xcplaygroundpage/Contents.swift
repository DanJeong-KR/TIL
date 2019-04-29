//: [Previous](@previous)

/***************************************************
 다음의 클로져를 FullSyntax 로부터 Optimized Syntax 로 차근차근 줄여보세요.
 (최종 답만 적지 말고 하나씩 줄여갈 것)
 ***************************************************/

func performClosure(param: (String) -> Int) {
  param("Swift")
}

// 전부 쓰기
performClosure(param: { (str: String) -> Int in
    
    return str.count
})

// 반환타입 생략
performClosure(param: { (str: String) in
    return str.count
})

// 매개변수 타입 생력
performClosure(param: {str in
    return str.count
})

// 클로저의 매개변수 생략하고 그 매개변수에 접근을 $0 으로 하기
performClosure(param: {
    return $0.count
})

// return 키워드 까지 생략하기
performClosure(param: {
    $0.count
})

// 클로저의 이름까지 생략.
performClosure() {
    $0.count }

// 트레일링 클로저이기 때문에 () 까지 생략가능
performClosure {
    $0.count
}

/***************************************************
 자연수 하나를 입력받아 1년부터 그 해까지의 모든 윤년의 개수를 출력하는 함수
 (공식 : 매 4년 마다 윤년. 매 100년 째에는 윤년이 아님. 매 400년 째에는 윤년)
 윤년O 예시 - 160, 204, 400, 1996, 2000, 2800
 윤년X 예시 - 200, 300, 500, 600, 1900, 2100
 
 Intput : 2019
 Output : 윤년에 속하는 해는 총 489회입니다.
 ***************************************************/

func printTheNumberOfLeafYear(_ year: Int) {
    var tempArray: [Int] = []
    
    for year in 1...year {
        if (year % 4 == 0 && year % 100 != 0) || year % 400 == 0 {
            tempArray.append(year)
        }
    }
  print("윤년에 속하는 해는 총 \(tempArray.count)회입니다.")
}

printTheNumberOfLeafYear(8)     // 2
printTheNumberOfLeafYear(100)   // 24
printTheNumberOfLeafYear(400)   // 97
printTheNumberOfLeafYear(2019)  // 489


/***************************************************
 주어진 문자 배열에서 중복되지 않는 문자만을 뽑아내 배열로 반환해주는 함수
 e.g.
 > Input : ["a", "b", "c", "a", "e", "d", "c"]
 > Output : ["b", "e" ,"d"]
 
 // sort 함수 사용하지 말 것
 ***************************************************/

func printUniqueValues(from arr: [String]) -> [String] {
    
    var tempArray = Array<String>()
    var resultArray = Array<String>()
    for (idx, value) in arr.enumerated() {
        tempArray = arr
        tempArray.remove(at: idx)
        if !tempArray.contains(value) {
            resultArray.append(value)
        }
    }
  return resultArray
}

let strArr = ["a", "b", "c", "a", "e", "d", "c", "a", "c", "f"]
print(printUniqueValues(from: strArr))   // b, e, d, f


/***************************************************
 자연수를 입력받아 그 숫자보다 작거나 같은 모든 소수와 그 개수를 출력하는 함수를 정의
 
 e.g.
 func checkPrimeNumbers(number: Int)
 > Input : 10
 > Output : 10보다 작거나 같은 소수는 [2, 3, 5, 7]이고, 총 4개입니다.
 ***************************************************/

// 3 - 1
// 4 - 1, 2
// 5 - 1,2,3,4


 // 못풀었음
func checkPrimeNumbers(number: Int) {

    var primeNums:[Int] = [2]
    
    if number < 2 { print("없습니다"); return }
    else if number == 2 {
        print("10보다 작거나 같은 소수는 \(primeNums) 이고, 총\(primeNums.count)개 입니다.")
    }
    else{

        for possible in 3...number { // number 보ㅓ다 작은 모든 숫자들 소수인지 검사
            // 소수 검사. / possible 이 나누어 떨어지는지
            //print("possible :",possible)
            var isNumberPrime = false
            for determine in 2...possible - 1 {
                isNumberPrime = false
                if possible % determine == 0 { break }
                else { isNumberPrime.toggle() }
                //print("determine :", determine, "isNumberPrime :",isNumberPrime)
            }
            if isNumberPrime == true { primeNums.append(possible) }
        }
    }
    print("10보다 작거나 같은 소수는 \(primeNums) 이고, 총\(primeNums.count)개 입니다.")
 
}
 

checkPrimeNumbers(number: 1)
checkPrimeNumbers(number: 10)   // 4개
checkPrimeNumbers(number: 100)  // 25개
checkPrimeNumbers(number: 1000) // 168개


/***************************************************
 구글(google), 카카오(kakao), 네이버(naver) 로그인을 위해 Site라는 이름의 Enum 타입을 만들고자 합니다.
 각 case는 사용자의 아이디(String)와 비밀번호(String)를 위한 연관 값(associated value)을  가집니다.
 그리고 Site 타입 내부에는 signIn()이라는 이름의 메서드를 만들어 다음과 같이 문자열을 출력하는 기능을 구현해보세요.
 
 e.g.
 enum Site {}
 > Input
 let google = Site.google("google@gmail.com", "0000")
 google.signIn()
 
 > Output
 구글에 로그인하였습니다. (아이디 - google@gmail.com, 비밀번호 - 0000)
 ***************************************************/


// 모르겠습니다.


//: [Next](@next)
