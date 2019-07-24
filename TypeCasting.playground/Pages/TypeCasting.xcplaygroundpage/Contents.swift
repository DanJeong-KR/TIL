//: [Previous](@previous)
/*:
 # Type Casting
 ---
 - as  : 타입 변환이 확실하게 가능한 경우(업캐스팅, 자기 자신 등) 에만 사용 가능. 그 외에는 컴파일 에러
 - as? : 강제 타입 변환 시도. 변환이 성공하면 Optional 값을 가지며, 실패 시에는 nil 반환
 - as! : 강제 타입 변환 시도. 성공 시 언래핑 된 값을 가지며, 실패 시 런타임 에러 발생
 ---
 */

import UIKit

class Shape {
  var color = UIColor.black
  
  func draw() {
    print("draw shape")
  }
}

class Rectangle: Shape {
  var cornerRadius = 0.0
  override var color: UIColor {
    get { return .white }
    set { }
  }
  
  override func draw() {
    print("draw rect")
  }
}

class Triangle: Shape {
  override func draw() {
    print("draw triangle")
  }
}

class Circle: Shape {
  var radius = 50.0
  
  override func draw() {
    print("draw circle")
  }
}



/*:
 ---
 ## Upcasting
 ---
 */
print("\n---------- [ Upcasting ] ----------\n")




let rect = Rectangle()
type(of: rect)
rect.color
rect.cornerRadius


let upcastedRect: Shape = Rectangle()
type(of: upcastedRect)   //
upcastedRect.color
//upcastedRect.cornerRadius

(rect as Shape) is Shape    //
(rect as Shape) is Rectangle   //
(rect as Rectangle) is Shape   //
(rect as Rectangle) is Rectangle   //

(upcastedRect as Shape) is Shape   //
(upcastedRect as! Rectangle) is Rectangle   //


/*:
 ---
 ## Downcasting
 ---
 */
print("\n---------- [ Downcasting ] ----------\n")



let shapeRect: Shape = Rectangle()
shapeRect.color    //
//shapeRect.cornerRadius   //


//let downcastedRect: Rectangle = shapeRect //
//let downcastedRect: Rectangle = shapeRect as! Rectangle   //
//downcastedRect.cornerRadius


//let downcastedRect: Rectangle? = shapeRect as? Rectangle  //
//let downcastedRect: Rectangle = shapeRect as! Rectangle  //
//downcastedRect.color         //
//downcastedRect.cornerRadius  //


if let downcastedRect = shapeRect as? Rectangle {
  print(downcastedRect)
}




//Q. 아래 value 에 대한 Casting 결과는?
let value = 1
//(value as Float) is Float   // error
//(value as? Float) is Float  // nil false
//(value as! Float) is Float  // error


/*:
 ---
 ## Type Check Operator
 ---
 */
let shape = Shape()
let rectangle = Rectangle()
let triangle = Triangle()
let circle = Circle()

//let list = [shape, rectangle, triangle, circle]
/*:
 ---
 ### Question
 - 아래 for 문에 대한 실행 결과는?
 ---
 */



print("\n---------- [ = ] ----------\n")
let list: [Shape] = [shape, rectangle, triangle, circle]
for element in list  {
  element.draw()
}

list[1].draw()

type(of: list[1])

// override 속성값에는 모두 접근할 수 있네
//: [Next](@next)
