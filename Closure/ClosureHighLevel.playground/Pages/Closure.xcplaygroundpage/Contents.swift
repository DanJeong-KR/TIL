//: [Previous](@previous)
/*:
 **function** - named code block
 
 **closure** - unnamed code block
 */
/***************************************************
 미지원 : Fortran, Pascal, Java 8버전 미만, C++11 버전 미만 등
 지원 : Swift, Objective-C, Python, Java 8 이상, C++11 이상, Javascript 등
 언어에 따라 Lambda, Block 등으로 불리우기도 함
 ***************************************************/

/***************************************************
 Functions are actually special cases of closures.
 
 - Global functions: closures that have a name and do not capture any values.
 - Nested functions: closures that have a name and can capture values from their enclosing function.
 - Closure: unnamed closures written in a lightweight syntax that can capture values from their surrounding context.
 ***************************************************/


//: ## Basic Closure
print("\n---------- [ Basic ] ----------\n")

func aFunction() {
  print("This is a function.")
}
aFunction()

({
  print("This is a closure.")
})()

func anotherFunction() {
  print("another function")
  ({
    print("another closure")
  })()
}
anotherFunction()

// 그냥 코드 작성하는 것과 차이?



print("\n---------- [ Save closure to variable ] ----------\n")

// 클로저도 변수에 담아 사용 가능
let closure = {
  print("This is a closure.")
}
closure()

// 함수도 저장 가능
var function = aFunction
function()

function = closure
function()



/***************************************************
 Closure Expression Syntax
 
 { <#(parameters)#> -> <#return type#> in
 <#statements#>
 }
 ***************************************************/
print("\n---------- [ Closure Syntax ] ----------\n")

func funcWithParamAndReturnType(_ param: String) -> String {
  return param + "!"
}
print(funcWithParamAndReturnType("function"))

// Type Annotation
let closureWithParamAndReturnType1: (String) -> String = { param in
  return param + "!"
}
print(closureWithParamAndReturnType1("closure"))

// Type Inference
let closureWithParamAndReturnType2 = { (param: String) -> String in
  return param + "!"
}
print(closureWithParamAndReturnType2("closure"))


let closureWithParamAndReturnType3 = { param in
  return param + "!"
}
print(closureWithParamAndReturnType3("closure"))


/*:
 ---
 ### Question
 - 문자열을 입력받으면 그 문자열의 개수를 반환하는 클로져 구현
 - 숫자 하나를 입력받은 뒤 1을 더한 값을 반환하는 클로져 구현
 ---
 */
// 1번 문제 예.   "Swift" -> 5
// 2번 문제 예.   5 -> 6


/*:
 ---
 ### Question
 - 그래서 클로져는 왜 쓸까요?
 ---
 */

/*:
 ## Syntax Optimization
 */
/***************************************************
 Swift's syntax optimizations
 - Inferring parameter and return value types from context
 - Implicit returns from single-expression closures
 - Shorthand argument names
 - Trailing closure syntax
 ***************************************************/

print("\n---------- [ Syntax Optimization ] ----------\n")

// 함수의 인자로, 입력된 문자열의 개수를 반환하는 클로저를 전달하는 예

func performClosure(param: (String) -> Int) {
  param("Swift")
}

performClosure(param: { (str: String) -> Int in
  return str.count
})

performClosure(param: { (str: String) in
  return str.count
})

performClosure(param: { str in
  return str.count
})

performClosure(param: {
  return $0.count
})

performClosure(param: {
  $0.count
})

performClosure(param: ) {
  $0.count
}

performClosure() {
  $0.count
}

performClosure { $0.count }


/***************************************************
 [ Closure 장점 ]
 문법 간소화 / 읽기 좋은 코드
 지연 생성
 주변 컨텍스트의 값을 캡쳐하여 작업 수행 가능
 ***************************************************/


/*:
 ## Inline closure
 - 함수의 인수(Argument)로 들어가는 클로저
 */
print("\n---------- [ Inline ] ----------\n")


func printSwiftFunction() {
  print("Swift!")
}
let printSwiftClosure = {
  print("Swift!")
}
func closureParamFunction(closure: () -> Void) {
  closure()
}

// closureParamFunction(closure: <#T##() -> Void#>)
// closureParamFunction { <#code#> }

closureParamFunction(closure: printSwiftFunction)
closureParamFunction(closure: printSwiftClosure)
closureParamFunction(closure: {
  print("Inline closure - Explicit closure parameter name")
})


/*:
 ## Trailing Closure
 - 함수의 괄호가 닫힌 후에도 인수로 취급되는 클로저
 - 함수의 마지막 인수(Argument)에만 사용 가능하고 해당 인수명은 생략
 - 하나의 라인에 다 표현하지 못할 긴 클로져에 유용
 */
print("\n---------- [ Trailing ] ----------\n")

// 후위 또는 후행 클로저
// closureParamFunction { <#code#> }

closureParamFunction() {
  print("Trailing closure - Implicit closure parameter name")
}


func multiClosureParams(closure1: () -> Void, closure2: () -> Void) {
  closure1()
  closure2()
}

multiClosureParams(closure1: {
  print("inline")
}, closure2: {
  print("inline")
})

multiClosureParams(closure1: {
  print("inline")
}) {
  print("trailing")
}



/*:
 ---
 ### Question
 - 정수를 하나 입력받아 2의 배수 여부를 반환하는 클로져
 - 정수를 두 개 입력 받아 곱한 결과를 반환하는 클로져
 ---
 */



/*:
 ---
 ### Answer
 ---
 */

/// 문자열을 입력받으면 그 문자열의 개수를 반환하는 클로져 구현

// 1단계 - 함수로 생각
func stringCount(str: String) -> Int {
  return str.count
}
print(stringCount(str: "Swift"))

// 2단계 - 클로져로 변형
({ (str: String) -> Int in
  return str.count
})("Swift")

// 3단계 - 클로저에 이름 부여
let stringCount = { (str: String) -> Int in
  return str.count
}
stringCount("Swift")


/// 숫자 하나를 입력받은 뒤 1을 더한 값을 반환하는 클로져 구현
let addOne = { (num: Int) -> Int in
  return num + 1
}
addOne(5)


/// 정수를 하나 입력받아 2의 배수 여부를 반환하는 클로져
let isEven = { (number: Int) -> Bool in
  return number % 2 == 0
}
isEven(6)
isEven(5)

/// 정수를 두 개 입력받아 곱한 결과를 반환하는 클로져
let multiplyTwoNumbers = { (op1: Int, op2: Int) -> Int in
  return op1 * op2
}

multiplyTwoNumbers(20, 5)
multiplyTwoNumbers(5, 10)


//: [Next](@next)
