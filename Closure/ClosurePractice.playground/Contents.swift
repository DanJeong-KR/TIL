/*:
 ## 1.함수의 매개변수로 closure 가 들어갈 때
* 클로저 optimizing 와
* trailing closure
 */
//: 문자열을 받아 문자열의 count를 반환하는 clousre 가 함수의 매개변수
func performClosure(param: (String) -> Int) { param("Swift") }
//: ---
//: 변환 과정
// general form
performClosure(param:{(str: String) -> Int in
    return str.count
})
// 클로저의 매개변수 타입 추론
performClosure(param: {str -> Int in return str.count})

// 클로저의 리턴 타입 추론
performClosure(param: {str in  return str.count})

// 리턴 키워드와 생략
performClosure(param: {str in str.count})

// 클로저의 매개변수 이름을 생략하고 축약어 사용 $0 $1 ...
// 클로저의 매개변수가 없으므로 in 도 자연스럽게 생략
performClosure(param: { $0.count})
//: Trailing Closure
// 함수의 마지막 매개변수가 클로저 일 때 함수의 매개변수 생략하고
// 마지막에  { } 후 클로저 문법 가능
performClosure() {
    $0.count
}
// () 까지 생략
performClosure { $0.count }
//: ---

//: ## 2. closure 생략해보기 연습문제
var someClosure: (String, String) -> Bool =
{ (s1: String, s2: String) -> Bool in
    let isAscending: Bool
    if s1 > s2 {
        isAscending = true
    } else {
        isAscending = false
    }
    return isAscending
}
//: ---
//: 변환 과정
// 매개변수와 리턴 타입 생략
someClosure = {
    s1,s2 in
    let isAscending: Bool
    if s1 > s2 {
        isAscending = true
    } else {
        isAscending = false
    }
    return isAscending
}

// 구문 줄이기
someClosure = {
    s1,s2 in
    let isAscending: Bool = s1 > s2
    return isAscending
}

// 매개변수 이름 축약어 사용하고 in 키워드 생략
someClosure = {
    let isAscending: Bool = $0 > $1
    return isAscending
}

// 구문 줄이기
someClosure = {
    return $0 > $1
}

// 리턴 키워드 생략
someClosure = { $0 > $1 }

someClosure("b","a")
//: ---

//: ## 3.클로저 optimizing 연습문제
var otherClosure: ([Int]) -> Int = { (values: [Int]) -> Int in
    var count: Int = 0
    for _ in values {
        count += 1
    }
    return count
}
//: ---
// 매개변수와 리턴타입 생략
otherClosure = {
    values in
    var count: Int = 0
    for _ in values {
        count += 1
    }
    return count
}

// 구문 줄이기.
otherClosure = {
    values in
    return values.count
}

// 매개변수 축약어 사용하고 in 키워드 생략하기
otherClosure = {
    return $0.count
}

// 리턴 키워드 생략하기
otherClosure = {
    $0.count
    
}
otherClosure([3,4,5])
//: ---


