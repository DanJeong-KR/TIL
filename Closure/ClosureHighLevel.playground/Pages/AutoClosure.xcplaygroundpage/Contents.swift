//: [Previous](@previous)
/*:
 # AutoClosure
 * 파라미터가 없는 표현식을 클로저로 변환하는 키워드
 * 파라미터가 없는 클로저에 사용 e.g. ()->(), ()->Int
*/

/*:
 ---
 ## NormalClosure
 ---
*/
print("\n---------- [ Normal Closure ] ----------\n")

var value1 = 10
func someFunc(_ str: String, _ closure: () -> ()) {
  print(str)
  closure()
}

someFunc("arg1") {
  print("closure")
}

someFunc("arg1") {
  value1 += 10
}

func myFunction() {}
someFunc("arg1", myFunction)

/*:
 ---
 ## AutoClosure
 ---
 */

var value2 = 10
func anotherFunction(_ str: String, _ closure: @autoclosure () -> ()) {
  print(str)
  closure()
}

/***************************************************
 closure 파라미터에 대입할 내용을 일반 함수 파라미터처럼 입력
 ***************************************************/
anotherFunction("arg1", print("Autoclosure"))

anotherFunction("arg1", value2 += 10)


/***************************************************
 일반 클로저처럼 사용 불가
 ***************************************************/

// Compile Error
//anotherFunction("arg1") {
//  print("Do Something")
//}

// Compile error
//anotherFunction("arg1", myFunction)


//: [Next](@next)
