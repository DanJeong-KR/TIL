//: [Previous](@previous)
/*:
 # Equatable, Identical
 */

// 동등 연산자
1 == 1
2 == 1
"ABC" == "ABC"


class Person {
  let name = "이순신"
  let age = 30
}

let person1 = Person()
let person2 = Person()

//person1 == "이순신"    //
//person1 == person2   //


/*:
 ---
 ### Question
 - 왜 비교 연산자를 사용할 수 없을까요?
 ---
 */

/*:
 ---
 ### Equatable Protocol
 ---
 */

class User: Equatable {
  var name = "이순신"
  let age = 30
  
  static func ==(lhs: User, rhs: User) -> Bool {
    return lhs.name == rhs.name
  }
}

let user1 = User()
var user2 = User()
user1 == user2


/*:
 ---
 ### Identical
 ---
 */

user1.name
user2.name
user1 == user2
user1 === user2

/***************************************************
 let x = 5
 let y = User()
 let z = User()
 
         x   y        z
 [Stack] | 5 | 0x5F17 | 0x2C90 |
 
      0x2C90         0x5F16      0x5F17
 [Heap] | z's user data | SomeData | y's user data |
 
 --- in Memory ---
 값 타입(Value Type) - Stack
 참조 타입(Reference Type) - Stack -> Heap
 ***************************************************/

user1.name = "홍길동"
user1.name   //
user2.name   //
user1 == user2
user1 === user2


//user1.name
//user2.name
//
//user2 = user1
//user2.name
//
//user1 == user2    //
//user1 === user2   //
//
//user2.name = "세종대왕"
//user1.name     //


/***************************************************
 Class Identity Operators
 === : Returns true when two constants or variables pointing to a same instance
 ***************************************************/

//1 === 1
//"A" === "A"

// 5 == 5


//: [Next](@next)
