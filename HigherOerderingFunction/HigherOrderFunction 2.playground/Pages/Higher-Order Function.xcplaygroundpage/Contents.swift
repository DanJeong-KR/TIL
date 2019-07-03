//: [Previous](@previous)
/***************************************************
 고차함수란?
 - 하나 이상의 함수를 인자로 취하는 함수
 - 함수를 결과로 반환하는 함수
 
 ※ 고차 함수가 되기 위한 조건은 함수가 1급 객체여야 한다.
 ***************************************************/

/***************************************************
 1급 객체 (First-class citizen)
 - 변수나 데이터에 할당할 수 있어야 한다.
 - 객체의 인자로 넘길 수 있어야 한다.
 - 객체의 리턴값으로 리턴할 수 있어야 한다.
 ***************************************************/

func firstClassCitizen() {
  print("function call")
}

func function(_ parameter: @escaping ()->()) -> (()->()) {
  return parameter
}

let returnValue = function(firstClassCitizen)
returnValue
returnValue()

//: [Next](@next)
