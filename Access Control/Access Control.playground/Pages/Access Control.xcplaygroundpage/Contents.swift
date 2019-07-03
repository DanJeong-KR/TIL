//: [Previous](@previous)
/*:
 ---
 ## Access Levels
 * open
 * public
 * internal
 * fileprivate
 * private
 ---
 */
//: [공식 문서](https://docs.swift.org/swift-book/LanguageGuide/AccessControl.html)

/***************************************************
 Open / Public
 ***************************************************/

open class SomeOpenClass {
  open var name = "name"
  public var age = 20
}

public class SomePublicClass {
  public var name = "name"
  var age = 20
}

let someOpenClass = SomeOpenClass()
someOpenClass.name
someOpenClass.age

let somePublicClass = SomePublicClass()
somePublicClass.name
somePublicClass.age

//: ---
/***************************************************
 Internal
 ***************************************************/

class SomeInternalClass {
  internal var name = "name"
  internal var age = 0
}

//class SomeInternalClass {
//  var name = "name"
//  var age = 0
//}


let someInternalClass = SomeInternalClass()
someInternalClass.name
someInternalClass.age

//: ---
/***************************************************
 fileprivate
 ***************************************************/

class SomeFileprivateClass {
  fileprivate var name = "name"
  fileprivate var age = 0
}

let someFileprivateClass = SomeFileprivateClass()
someFileprivateClass.name
someFileprivateClass.age


//: ---

class SomePrivateClass {
  private var name = "name"
  private var age = 0
  
  func someFunction() {
    print(name)
  }
}

//let somePrivateClass = SomePrivateClass()
//somePrivateClass.someFunction()
//somePrivateClass.name
//somePrivateClass.age



/***************************************************
 1. Command Line Tool 로 체크
 2. UIViewController, Int 등 애플 프레임워크의 접근 제한자 확인
 ***************************************************/


/*:
 ---
 ## Nested Types
 * Private  ->  Private  // 실제로는 Fileprivate
 * Fileprivate  ->  Fileprivate
 * Internal  ->  Internal
 * Public  ->  Internal
 * Open  ->  Internal
 ---
 */
// 예시
open class AClass {
  // 별도로 명시해주지 않으면 someProperty 는 Internal 레벨
  var someProperty: Int = 0
}


//: [Next](@next)
