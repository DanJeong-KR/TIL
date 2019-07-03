//: [Previous](@previous)
/*:
 # Initializer
 ---
 * Swift 의 객체는 사용하기 전 모든 저장 프로퍼티에 대해 초기화 필수
 * 다음 3 가지 중 하나를 택해 초기화
   * 초기값 지정
   * 옵셔널 타입 - nil 값으로 초기화
   * 초기값이 없고, 옵셔널 타입이 아닌 프로퍼티에 대해서는 초기화 메서드에서 설정
 ---
 */
class Circle {
  var desc: String?
  var radius: Int = 20
  var xCoordinate: Int
  var yCoordinate: Int
  
  init() {
    xCoordinate = 5
    yCoordinate = 10
  }
  
  init(xCoordinate: Int, yCoordinate: Int) {
    self.xCoordinate = xCoordinate
    self.yCoordinate = yCoordinate
  }
}

let circle1 = Circle()
let circle2 = Circle(xCoordinate: 10, yCoordinate: 5)




/*:
 ---
 ## Designated Initializer
 - 클래스에 반드시 1개 이상 필요
 - 초기화가 필요한 모든 프로퍼티를 단독으로 초기화 가능한 Initializer
 - 위에서 사용한 init(), init(height: Int, xPosition: Int) 가 여기에 해당
 - 초기화 과정에서 반드시 한 번은 호출
 ---
 */


/*:
 ---
 ## Convenience Initializer
 - 단독으로 모두 초기화할 수 없고 일부만 처리한 뒤 다른 생성자에게 나머지 부분 위임
 - 중복되는 초기화 코드를 줄이기 위해 사용
 ---
 */

class Rectangle {
  var width: Int
  var height: Int
  var xPosition: Int
  var yPosition: Int
  var cornerRadius: Int
  
  init() {
    // designated init 1
    width = 20
    height = 20
    xPosition = 10
    yPosition = 10
    cornerRadius = 5
  }
  
    // designated init 2
  init(width: Int, height: Int, xPosition: Int, yPosition: Int, cornerRadius: Int) {
    // designated init
    self.width = width
    self.height = height
    self.xPosition = xPosition
    self.yPosition = yPosition
    self.cornerRadius = cornerRadius
    
    // self.init()  // 초기화 메소드에서 다른 초기화 메소드를 호출하려면 에러 -> convenience 키워드 붙여야.
  }
  

  convenience init(xPosition: Int) {
    // convenience init -> designated init -> overwrite
    self.init() // designated init
    self.xPosition = xPosition // 하나의 값만 overwrite 하고 싶을 때.
  }
  
    // 3개만 외부에서 받아서 넣고 싶고 x,yPosition 만 상수로 초기화 하고.
  convenience init(width: Int, height: Int, cornerRadius: Int) {
    // convenience init -> designated init
    self.init(width: width, height: height, xPosition: 10, yPosition: 30, cornerRadius: cornerRadius)
  }

    //convenience 안에 또 다른 convenience 메소드는 사용 가능하다.
  convenience init(cornerRadius: Int) {
    // convenience init -> convenience init
    self.init(width: 20, height: 20, cornerRadius: cornerRadius)
  }
}


// designated 초기화는 무조건 하나 이상 있어야 하고
// convenience 는 있어도 되고 없어도 되는데 조금 더 디테일하게 내가 원하는 init 을 할 수 있고
// 중독되는 초기화 코드를 줄일 수 있어. 사용하는 사람에 따라 필요한 게 다를 테니

// 예를 들어 UIButton 초기화 해보면 초기화 메소드 필요에 따라 2개가 뜸. Frame 으로 초기화 할건지 다른 걸로 초기화 할 건지.

let rectangle1 = Rectangle(xPosition: 20)
let rectangle2 = Rectangle(cornerRadius: 5)
let rectangle3 = Rectangle(width: 10, height: 10, xPosition: 10, yPosition: 5, cornerRadius: 3)


/***************************************************
 초기화 과정은 (Convenience -> Convenience -> ... ->) Designated (최종) 순서로 동작
 Designated -> Designated 호출 불가
 ***************************************************/


/*:
 ---
 ## Failable Initializer
 - 인스턴스 생성시 특정 조건을 만족하지 않으면 객체를 생성하지 않는 것
 - 생성이 되면 옵셔널 타입을 반환하게 되며, 생성 실패시에는 nil 반환
 ---
 */


class Person {
  let name: String
  let age: Int
  
  init?(name: String, age: Int) { // init 뒤에 ? 붙음.
    guard age > 0 else { return nil } // 나이가 0 살 보다 높아야 초기화되게 ,
    self.name = name
    self.age = age
  }
}

//Failable Initializer

if let person = Person(name: "James", age: 20) {
  person
}

if let person = Person(name: "James", age: -5) {
  person
} else {
  "Failed"
}

let person = Person(name: "chang", age: 0)

// init 은 반환값이 있는 func 이 아닌 특별한 메소드
// func 이 안붙는 이유
// 자기 자신의 인스턴스를 생성하는 역할
//: [Next](@next)
