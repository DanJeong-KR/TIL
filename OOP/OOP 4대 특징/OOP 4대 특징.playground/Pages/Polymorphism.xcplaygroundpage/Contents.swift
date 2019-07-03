//: [Previous](@previous)
import UIKit
//: - - -
//: # Polymorphism
//: * Overloading
//: * Overriding
//: - - -
//: ## Overloading
/***************************************************
 1. 다른 파라미터 이름
 2. 다른 파라미터 타입
 3. 다른 파라미터 개수
 ***************************************************/

print("\n---------- [ Overloading ] ----------\n")

func printParameter() {
    print("No param")
}

//func printParameter() -> String {   // Error
//  print("No param")
//}

func printParameter(param: Int) {
    print("Input :", param)
}

func printParameter(_ param: Int) {
    print("Input :", param)
}

print("=====")
printParameter()
printParameter(param: 1)
printParameter(1)


// ---------

func printParameter(param: String) {
    print("Input :", param)
}

func printParameter(_ param: String) {
    print("Input :", param)
}

func printParameter(name param: String) {
    print("Input :", param)
}

//func printParameter(param name: String) {   // Error
//  print("Input :", name)
//}


print("=====")
printParameter(param: "hello")
printParameter("hello")
printParameter(name: "Hello")


/////////

func printParameter(param: String, param1: String) {
    print("Input :", param, param1)
}

func printParameter(_ param: String, _ param1: String) {
    print("Input :", param, param1)
}

func printParameter(_ param: String, param1: String) {
    print("Input :", param, param1)
}

func printParameter(param: String, _ param1: String) {
    print("Input :", param, param1)
}


print("=====")
printParameter(param: "hello", param1: "world")
printParameter("hello", "world")
printParameter("hello", param1: "world")
printParameter(param: "hello", "world")



//: ## Overriding

print("\n---------- [ Overriding ] ----------\n")

class Shape {
    final var lineWidth = 3
    var color = UIColor.black
    var title = "Shape"
    
    init(color: UIColor) {
        self.color = color
    }
    
    func draw() {
        print("draw shape")
    }
}


let shape = Shape(color: .cyan)
shape.color
shape.draw()


print("\n---------- [ Rectangle ] ----------\n")

class Rectangle: Shape {
    var cornerRadius = 0.0
    
    // 저장 프로퍼티로는 불가능
//    override var color: UIColor = .green
    // 계산 프로퍼티로는 변경이 가능
    override var color: UIColor {
        get {
            return super.color
        }
        set {
            super.color = newValue
        }
    }
    
    init(color: UIColor, cornerRadius: Double = 10.0) {
        super.init(color: color)
        self.cornerRadius = cornerRadius
    }
}

let rect = Rectangle(color: UIColor.blue)
rect.color
rect.cornerRadius
rect.lineWidth
rect.draw()



print("\n---------- [ Triangle ] ----------\n")

class Triangle: Shape {
    //  override var color: UIColor  = .green
    
    //  override var color: UIColor {
    //    get {
    //      return super.color
    //    }
    //    set {
    //      super.color = newValue
    //    }
    //  }
    
    override var title: String {
        get {
            //      return "Triangle"
            return super.title + " => Triangle"
        }
        set {
            super.title = newValue
        }
    }
    
    override func draw() {
        super.draw()
        print("draw triangle")
    }
}


let triangle = Triangle(color: UIColor.blue)
triangle.color
triangle.color = .yellow
triangle.color

shape.title
triangle.title = "asd"
shape.title
triangle.title

//triangle.cornerRadius
triangle.draw()



/*:
 ---
 ### Question
 - PDF의 문제를 참고하여 Overriding 적용해보기
 ---
 */
// bark() 메서드를 가진 Dog 클래스를 상속받아 Poodle, Husky, Bulldog 이 서로 다르게 짖도록 구현하기

class Dog {
    func bark() {
        print("멍멍")
    }
}





/*:
 ---
 ### Answer
 ---
 */
class Dog1 {
    func bark() {
        print("멍멍")
    }
}

class Poodle1: Dog1 {
    override func bark() {
        print("왈왈")
    }
}

class Husky1: Dog1 {
    override func bark() {
        print("으르르")
    }
}

class Bulldog1: Dog1 {
    override func bark() {
        super.bark()
        print("bowwow")
    }
}

// Dog 타입의 객체에 bark 메서드를 실행하라는 메시지 전달
// override 된 경우 해당 메서드를 찾아서 실행

print("\n---------- [ Dog ] ----------")
var dog1: Dog1 = Dog1()
dog1.bark()
print("\n---------- [ Poodle ] ----------")
dog1 = Poodle1()
dog1.bark()
print("\n---------- [ Husky ] ----------")
dog1 = Husky1()
dog1.bark()
print("\n---------- [ Bulldog ] ----------")
dog1 = Bulldog1()
dog1.bark()




//: [Next](@next)
