//: [Previous](@previous)
/*:
 ---
 # Inheritance
 ---
 */

class Cat {
  let leg = 4
  func cry() {
    print("miaow")
  }
}

class KoreanShortHair: Cat {}

let cat = Cat()
print(cat.leg)
cat.cry()

let koshort = KoreanShortHair()
print(koshort.leg)
koshort.cry()


/*:
 ---
 ### Question
 Person, Student, University Student 클래스 구현하고 관련 속성 및 메서드 구현
 - 상속을 하지 않고 각각 개별적으로 만들면 어떻게 구현해야 하는지 확인
 - 상속을 적용하면 어떻게 바뀌는지 확인
 ---
 */
class Person {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

class Student: Person {
    let grade: Int
    init(grade: Int, name: String) {
        self.grade = grade
        super.init(name: name)
    }
}

class UniversityStudent: Student {
    let major: String
    init(major: String, name: String, grade: Int) {
        self.major = major
        super.init(grade: grade, name: name)
    }
}



/*:
 ## final
 */
print("\n---------- [ Final ] ----------\n")

class Shape {
}

final class Circle: Shape {
}

//class Oval: Circle {
//}



/*:
 ---
 ### Answer
 ---
 */

class Person1 {
  let name = "홍길동"
  let age = 20
  
  func eat() {
    print("eat")
  }
}


print("\n---------- [ Without Subclassing ] ----------\n")

//class Student1 {
//  let name = "홍길동"
//  let age = 20
//  let grade = "A"
//
//  func eat() {
//    print("eat")
//  }
//  func study() {
//    print("study")
//  }
//}
//
//class UniversityStudent1 {
//  let name = "홍길동"
//  let age = 20
//  let grade = "A"
//  let major = "Computer Science"
//
//  func eat() {
//    print("Eat")
//  }
//  func study() {
//    print("Study")
//  }
//  func goMT() {
//    print("Go membership training")
//  }
//}


print("\n---------- [ Subclassing ] ----------\n")

class Student1: Person1 {
  let grade = "A"
  
  func study() {
    print("study")
  }
}

class UniversityStudent1: Student1 {
  let major = "Computer Science"
  
  func goMT() {
    print("Go membership training")
  }
}



//: [Next](@next)
