//: [Previous](@previous)

import UIKit

final class MemoryViewController: UIViewController {
  
    // 사람.
  final class Person {
    // 아파트
    var apartment: Apartment?
    let name: String
    
    init(name: String) {
      self.name = name
    }
    deinit {
      print("\(name) is being deinitialized")
    }
  }
  
    // 아파트.
  final class Apartment {
    weak var tenant: Person?
    let unit: String
    
    init(unit: String) {
      self.unit = unit
    }
    deinit {
      print("Apartment \(unit) is being deinitialized")
    }
  }
  
    //
  var person: Person? = Person(name: "James")
  var apartment: Apartment? = Apartment(unit: "3A")
  
    
  func loadClass() {
    person?.apartment = apartment
    apartment?.tenant = person
  }
  
  deinit {
    print("MemoryViewController is being deinitialized")
  }
}


var memoryVC: MemoryViewController? = MemoryViewController()
memoryVC?.loadClass()
memoryVC = nil


/***************************************************
 1. 문제가 있는지 없는지 확인
 2. 문제가 없다면 참조카운트가 어떻게 바뀌면서 잘 해결이 되었는지 정리하고
    문제가 있다면 어떤 부분이 그런지 알아보고 직접 해결해 볼 것
 ***************************************************/

// Apartment 클래스의 tenant 를 weak var tenant 로 바꾸면 된다.


//: [Next](@next)
