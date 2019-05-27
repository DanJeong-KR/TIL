//: [Previous](@previous)
import Foundation
/*:
 ---
 # Escaping
 - 함수나 메서드의 파라미터 중 클로져 타입에 @escaping 키워드 적용
 - 해당 파라미터가 함수 종료(return) 이후 시점에도 어딘가에 남아 실행될 수 있음을 나타냄
   - outlives the lifetime of the function
 - 해당 파라미터가 함수 외부에 저장(stored)되거나 async(비동기)로 동작할 때 사용
 - self 키워드 명시 필요
 ---
 */

class Callee {
  func noEscapingFunc(closure: () -> Void) {
    closure()
  }
  func escapingFunc(closure: @escaping () -> Void) {
    closure()
  }
  init() { print("Callee has initialized") }
  deinit { print("Callee has deinitialized") }
}

class Caller {
  let callee = Callee()
  var name = "James"
  
  func selfKeyword() {
    // self keyword (X)
    callee.noEscapingFunc { name = "Tom" }
    
    // self keyword  (O)
    callee.escapingFunc { self.name = "Tom" }
    
    // 실제 escaping 여부와 관계없이 @escaping 키워드가 있으면 self 키워드 필요
  }
    
    // Animation 의 경우 UIView.animate 함수가 끝나고 나서도 duration 기간동안 클로져가 살아있어야 하므로 @escaping 이어야 하고 self 를 붙여야 한다.
  
  func asyncTask() {
    callee.escapingFunc {
      DispatchQueue.main.async {
        self.name = "Tom"
      }
    }
    
    // 파라미터를 전달하는 측에서의 비동기 코드는 escaping 과 무관
    callee.noEscapingFunc {
      name = "Tom"   // OK
      DispatchQueue.main.async {
//        name = "Tom"   // Error
        self.name = "Tom"
      }
    }
  }
  
  func captureAsStrong() {
    callee.escapingFunc {
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        print("\n-- after 2seconds --")
        self.name = "Tom"
        print(self.name)
        // self.name 이 해제되어야 메모리에서 해제
      }
    }
  }
  
  func weakBinding() {
    callee.escapingFunc { [weak self] in //
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        print("\n-- after 2seconds with weak self --")
        self?.name = "Tom"
        print(self?.name ?? "nil")
        // self가 해제되는 순간 nil
      }
    }
  }
  
  func unownedBinding() {
    callee.escapingFunc { [unowned self] in
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        print("\n-- after 2seconds with unowned self --")
        self.name = "Tom"
        print(self.name)
        print("Oops!!")
        // self가 해제된 상태에서 접근하면 crash
      }
    }
  }
  
  init() { print("Caller has initialized") }
  deinit { print("Caller has deinitialized") }
}


print("[ Init ]")
var caller: Caller? = Caller()

print("\n[ Deinit ]")
//caller?.selfKeyword()
//caller?.asyncTask()
//caller?.captureAsStrong()
//caller?.weakBinding()
caller?.unownedBinding()

print("caller = nil")
caller = nil

print("\n[ End ]\n")




//: [Next](@next)
