//: [Previous](@previous)
import Foundation
/*:
 # Property
 */
/*:
 ---
 ## Stored Property
 - Class ⭕️   Structure ⭕️   Enumeration ❌
 ---
 */
class StoredProperty {
  var width = 0.0
  var height = 0.0
}

let stored = StoredProperty()
stored.width = 123
stored.height = 456
stored.width
stored.height

/*:
 ---
 ## Lazy Stored Property
 - 초기값이 인스턴스의 생성이 완료 될 때까지도 알 수 없는 외부 요인에 의존 할 때
 - 초기값이 복잡하거나 계산 비용이 많이 드는 설정을 필요로 할 때
 - 필요한 경우가 제한적일 때
 - Class ⭕️   Structure ⭕️   Enumeration ❌
 ---
 */
print("\n---------- [ Lazy Property ] ----------\n")

class BasicStoredProperty {
  var width = 10.0
  var height = 20.0
  
  var area = 200.0
//  var area = self.width * self.height
}

let basicStored = BasicStoredProperty()
basicStored.area
basicStored.width = 30
basicStored.area



class LazyStoredProperty {
  var width = 10.0
  var height = 20.0
  
  // 1. 외부 요인이나 다른 설정에 기반
//  var area = self.width * self.height
  lazy var area = width * height
  
  // 2. 계산 비용이 많이 드는 상황
//  var hardWork = "실행하면 약 10초 이상 걸려야 하는 작업"
  
  // 3. 필요한 경우가 제한적인 상황
//  func ifStatement() {
//    if true {   // 10%
//      print(area)
//    } else {    // 90%
//      print(width)
//    }
//  }
}

let lazyStored = LazyStoredProperty()
lazyStored.width = 30
lazyStored.area


// 순서 주의
let lazyStored1 = LazyStoredProperty()
lazyStored1.area
lazyStored1.width = 30
lazyStored1.area


/*:
 ---
 ## Computed Property
 - 자료를 저장하지 않고 매번 호출할 때마다 새로 계산
 - Class ⭕️   Structure ⭕️   Enumeration ⭕️
 ![ComputedProperty](computed.png)

 ---
 */
print("\n---------- [ Computed Property ] ----------\n")

class ComputedProperty {
  var width = 5.0
  var height = 5.0
  
  lazy var lazyArea = width * height
  var area: Double {
    return width * height
  }
  
  // Computed + Stored
  private var _koreanWon = 0.0
  var wonToDollar: Double {
    get {
      return _koreanWon / 1136.5
    }
    set {
      _koreanWon = newValue
    }
  }
}

var computed = ComputedProperty()
computed.area
computed.lazyArea

computed.width = 10
computed.area
computed.lazyArea

computed.lazyArea = 50.0
computed.lazyArea

computed.width = 20
computed.height = 20
computed.area
computed.lazyArea

computed.wonToDollar
computed.wonToDollar = 10000
computed.wonToDollar


/*:
 ---
 ## Property Observer
 - Class ⭕️   Structure ⭕️   Enumeration ❌
 ![property-observer](property-observer.png)
 ---
 */
print("\n---------- [ Property Observer ] ----------\n")

class PropertyObserver {
  var height = 0.0
  
  var width = 0.0 {
    willSet {
      print("willSet :", width, "->", newValue)
    }
    didSet {
      print("didSet :", oldValue, "->", width)
    }
  }
}

var obs = PropertyObserver()
obs.height = 456
obs.width = 123


/*:
 ---
 ## Type Property
 - Shared
 - Lazily Initialized
 - Class ⭕️   Structure ⭕️   Enumeration ⭕️
 ---
 */
/***************************************************
 선언 - static let(var) <#propertyName#>: <#Type#>
       class var <#propertyName#>: <#Type#> { return <#code#> }
 사용 - <#TypeName#>.<#propertyName#>
 
 static: override 불가
 class: 클래스에서만 사용 가능하고 computed property 형태로 사용. 서브클래스에서 override 가능
 ***************************************************/

print("\n---------- [ Type Property ] ----------\n")

class TypeProperty {
  static var unit: String = "cm"
  var width = 5.0
}

let square = TypeProperty()
square.width

let square1 = TypeProperty()
square1.width = 10.0
square1.width

TypeProperty.unit
print("\(square.width) \(TypeProperty.unit)")
print("\(square1.width) \(TypeProperty.unit)")

TypeProperty.unit = "m"
print("\(square.width) \(TypeProperty.unit)")
print("\(square1.width) \(TypeProperty.unit)")


//: [Next](@next)
