//: [Previous](@previous)
import Foundation
/*:
 ---
 # NoEscaping
 - 기본값 (Swift 3.0 버전 이전까지는 @escaping이 기본)
 - 함수에서 사용된 파라미터는 함수 종료와 함께 소멸
 - self 키워드 불필요
 ---
 */
class Callee {
  func doSomething(closure: () -> Void) {
    closure()
  }
  init() { print("Callee has initialized") }
  deinit { print("Callee has deinitialized") }
}

class Caller {
  let callee = Callee()
  var name = "James"
  
  func doSomething() {
    callee.doSomething {
      self.name = "Tom"
      
      // self 키워드 불필요
      name = "Tom"
    }
  }
  init() { print("Caller has initialized") }
  deinit { print("Caller has deinitialized") }
}


print("---------- [ NoEscaping ] ----------\n")

print("[ Init ]")
var caller: Caller? = Caller()

print("\n[ Deinit ]")
caller?.doSomething()
caller = nil

print("\n[ End ]")


/*:
 ---
 ## Compatibility
 ---
 */
/***************************************************
 (O) @noescaping -> @noescaping
 (O) @escaping   -> @noescaping, @escaping
 (X) @noescaping -> @escaping
 ***************************************************/

class Test {
  var storedProperty: (() -> ())?
  
  func someFunction(_ param: @escaping ()->()) {
    // (X) required @escaping
    self.storedProperty = param // 매개변수 param 이 storedProperty 에 남기 때문에 @escaping 키워드 필요
    // 끝났는데 외부에 탈출해서 남으니까 @escaping
    
    // (O) NoEscaping -> NoEscaping
    noEscapingClosure(param)
    
    // (X) NoEscaping -> Escaping
//    escapingClosure(param)
  }
  
  func noEscapingClosure(_ param: @escaping () -> ()) {
    param()
    
    // (X) required @escaping
    self.storedProperty = param
  }
  
  func escapingClosure(_ param: @escaping () -> ()) {
    param()
    self.storedProperty = param
  }
}

let _ = Test()


//: [Next](@next)
