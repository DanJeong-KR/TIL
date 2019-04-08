//: [Previous](@previous)
import Foundation
import UIKit
/*:
 # Singleton
 - 특정 클래스의 인스턴스에 접근할 때 항상 동일한 인스턴스만을 반환하도록 하는 설계 패턴
 - 한 번 생성된 이후에는 프로그램이 종료될 때까지 항상 메모리에 상주
 - 어플리케이션에서 유일하게 하나만 필요한 객체에 사용
 - UIApplication, AppDelegate 등
 */

/***************************************************
 iOS 싱글톤 사용 예
 ***************************************************/
let screen = UIScreen.main
let userDefaults = UserDefaults.standard
let application = UIApplication.shared
let fileManager = FileManager.default
let notification = NotificationCenter.default

// 프로퍼티 사용하듯이 () 를 붙이지 않고 dot notation 으로 선언한다 특이하게
// 사용할 때 따로 변수에 넣어서 사용하지 않고 클래스에서 접근해서 사용하면 되네. UserDefaults 쓰다가 알게 됬음.
/*:
 ## Syntax
 */
//: ### Obj-C
//: ![objc_singleton](objc_singleton.png)
/*:
 ### Swift
 */

class NormalClass {
  var x = 0
}

let someObject1 = NormalClass()
someObject1.x = 5

let someObject2 = NormalClass()
someObject2.x = 1

let someObject3 = NormalClass()
someObject3.x = 10

someObject1.x
someObject2.x
someObject3.x



/***************************************************
 let으로 선언한 것은 기본적으로 thread-safe 하므로 Objective-C 처럼 별도로 dispatch_once_t 불필요
 static 전역 변수로 선언한 것은 lazy 하게 동작하므로 처음 Singleton을 생성하기 전까지 메모리에 올라가지 않음
 ***************************************************/

// static 은 lazy 한 특성
class SingletonClass {
    // 타입 프로퍼티 (전역변수) -> 한번 생성된 이후에는 프로그램이 종료될 때까지 메모리에 상주함.
  static let shared = SingletonClass() // 자기 자신의 인스턴스를 저장.
  var x = 0
}

//
let singleton1 = SingletonClass.shared // SingletonClass() 가 들어감.
singleton1.x = 10

let singleton2 = SingletonClass.shared
singleton2.x = 20

singleton1.x   //
singleton2.x   //
// 같은 값을 가져. 이렇게 생성한

// 다른 방식으로 저장하면?
SingletonClass.shared.x = 30

SingletonClass.shared.x  //
singleton1.x  //
singleton2.x  //
// 전부 30으로 바뀐다.
// shared 로


SingletonClass().x = 99
SingletonClass().x
// 왜 0 일까 ? , 위의 2 개는 서로 다른 아이라서. 서로 다른 인스턴스
singleton1.x  //
singleton2.x  //


/***************************************************
 Q.
 하나의 객체만을 공용으로 사용하기 위해 싱글톤 클래스를 만들었는데
 현재 상태에서 생길 수 있는 문제점은?
 (항상 하나의 객체만을 사용하는 것을 강제해야 하는 상황)
 ***************************************************/


class Singleton {
  static let shared = Singleton()
  var x = 0
}

let object1 = Singleton.shared


// 여전히 새로운 객체를 만들고 다른 객체에 접근 가능

let object2 = Singleton()
object1.x = 10
object2.x = 20

object1.x
object2.x


/***************************************************
 외부에서 인스턴스를 직접 생성하지 못하도록 강제해야 할 경우 생성자를 private 으로 선언
 단, 일부러 새로운 것을 만들어서 쓸 수 있는 여지를 주고 싶은 경우는 무관
 ***************************************************/

class PrivateSingleton {
  static let shared = PrivateSingleton()
  private init() {} // init 에 private 으로 외부에서 초기화 못시키게 함으로써 싱글톤을 구현!
  var x = 1
}

//let uniqueSingleton = PrivateSingleton.init()
let uniqueSingleton1 = PrivateSingleton.shared
let uniqueSingleton2 = PrivateSingleton.shared
uniqueSingleton1.x
uniqueSingleton2.x

uniqueSingleton1.x = 20

uniqueSingleton1.x
uniqueSingleton2.x


//: [Next](@next)
