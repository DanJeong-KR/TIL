//: [Previous](@previous)
/*:
 ---
 ## Class Initialize
 ---
 */
/*:
 ---
 ### Class 의 초기화 메서드
 - 초기화(init)가 불필요한 경우 : 모든 저장 프로퍼티에 초기값이 설정되어 있음
 - 초기화(init)가 필요한 경우 : 저장 프로퍼티 중 하나 이상이 초기값 미설정됨
 ---
 */

/***************************************************
 모든 저장 프로퍼티 (Stored Properties)에 초기값이 설정된 경우 Init 메서드 작성 불필요
 객체 생성시 단순히 ClassName() 만으로 생성 가능
 ***************************************************/

class Dog1 {
  let name = "Tory"
  let color = "Brown"
  
  func bowwow() {
    print("Dog1 Bowwow!")
  }
}

let tory = Dog1()
// let tory = Dog1.init()
tory.bowwow()



/***************************************************
 초기화 메서드가 필요한 경우 - 저장 프로퍼티 중 하나 이상이 초기값 미설정
 ==> init 메서드를 통해 설정
 ***************************************************/

// 파라미터 없는 경우

class Dog2 {
  let name: String
  let color: String
  
  init() {
    name = "Tory"
    color = "Brown"
  }
  
  func bowwow() {
    print("Dog2 Bowwow!")
  }
}

let tory2 = Dog2()
tory2.bowwow()




// 파라미터를 통해 설정하는 경우

class Dog3 {
  let name: String
  let color: String

  init(name: String) {
    self.name = name
    color = "Brown"
  }
  init(name: String, color: String) {
    self.name = name
    self.color = color
  }
  
  func bowwow() {
    print("Dog3 Bowwow!")
  }
}

var tory3 = Dog3(name: "Tory")
var tory4 = Dog3(name: "Tory", color: "White")

tory3.name
tory3.color

tory4.name
tory4.color


/*:
 ---
 ### Question
 - 전 단계에서 만든 자동차 클래스의 초기값을 제거하고 Init 메서드를 이용해 생성하기
 ---
 */
/***************************************************
 자동차 클래스
 - 속성: 차종(model), 연식(model year), 색상(color) 등
 - 기능: 운전하기(drive), 후진하기(reverse) 등
 ***************************************************/



/*:
 ---
 ### Answer
 ---
 */
print("\n---------- [ Answer ] ----------\n")

class Car {
  let model: String
  let modelYear: Int
  let color: String
  
  init(model: String, modelYear: Int, color: String) {
    self.model = model
    self.modelYear = modelYear
    self.color = color
  }
  
  func drive() {
    print("전진")
  }
  func reverse() {
    print("후진")
  }
}

let car = Car(model: "경운기", modelYear: 2019, color: "Gray")
car.model
car.modelYear
car.color
car.drive()
car.reverse()


//: [Next](@next)
