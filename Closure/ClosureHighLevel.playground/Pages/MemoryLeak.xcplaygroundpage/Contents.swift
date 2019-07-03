//: [Previous](@previous)
//: # MemoryLeak
import Foundation

final class Callee {
  var storedProperty: (() -> ())?
  
  func noEscapingFunc(closure: () -> Void) {
    DispatchQueue.main.async {
      // Compile Error
//      closure()
//      self.storedProperty = closure
    }
  }
  func escapingFunc(closure: @escaping () -> Void) {
    DispatchQueue.main.async {
      closure()
      self.storedProperty = closure
    }
  }
  
  init() { print("Callee has initialized") }
  deinit { print("Callee has deinitialized") }
}


final class Caller {
  let callee = Callee()
  var name = "James"
  
  func memoryLeak() {
    // Leak
    callee.escapingFunc {
      self.name = "Tom"
    }
    
    // Release
//    callee.escapingFunc { [weak self] in
//      self?.name = "Tom"
//    }
  }
  
  func anotherLeak() {
//    callee.escapingFunc {
//      DispatchQueue.main.async { [weak self] in
//        self?.name = "Tom"
//      }
//    }
    
    // Q. 어떻게 해제할 수 있을까?
    callee.escapingFunc { [weak self] in
        DispatchQueue.main.async {
            self?.name = "Tom"
        }
    }
    
  }
  //  아 지 루 해..
    //ya gojeongah     na  BBakchige hajima```
  init() { print("Caller has initialized") }
  deinit { print("Caller has deinitialized") }
}

print("---------- [ Escaping02 ] ----------\n")

print("[ Init ]")
var caller: Caller? = Caller()

print("\n[ Deinit ]")
caller?.memoryLeak()
//caller?.anotherLeak()
caller = nil

print("\n[ End ]")

//: [Next](@next)
