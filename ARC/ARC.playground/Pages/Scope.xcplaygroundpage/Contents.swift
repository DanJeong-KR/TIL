//: [Previous](@previous)
/*:
 ---
 # Scope
   - 스코프 범위에 의한 할당 및 해제
 ---
 */


class LocalScope {
  func doSomething() {}
  deinit {
    print("LocalScope is being deinitialized")
  }
}

class ClassProperty {
  func doSomething() {}
  deinit {
    print("ClassProperty is being deinitialized")
  }
}

class Application {
  var prop = ClassProperty()
  
  func allocateInstance() {
    let local = LocalScope() // rc 1
    local.doSomething()
  } // rc 0
  
  deinit {
    print("Application is being deinitialized")
  }
}


// Q. 아래의 코드 실행 시 출력되는 메시지는?

var app: Application? = Application()
app?.prop.doSomething()
app?.allocateInstance()
app?.allocateInstance()
app = nil


// Q. ClassProperty 객체의 deinit 메서드가 호출되려면 어떻게 할까요?




//: [Next](@next)
