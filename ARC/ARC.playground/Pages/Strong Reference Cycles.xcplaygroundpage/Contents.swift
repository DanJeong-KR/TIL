//: [Previous](@previous)
/*:
 ---
 # Strong Reference Cycles
 ---
 */

class Person {
  var pet: Dog?
  func doSomething() {}
  deinit {
    print("Person is being deinitialized")
  }
}

class Dog {
  var owner: Person?
  func doSomething() {}
  deinit {
    print("Dog is being deinitialized")
  }
}


var giftbot: Person! = Person() // Person rc 1
var tori: Dog! = Dog() // Dog rc 1


giftbot.pet = tori // Dog rc 2
tori.owner = giftbot // Person rc 2


giftbot.doSomething()
tori.doSomething()

/*:
 ---
 ### Question
 - 두 객체를 메모리에서 할당 해제하려면 어떻게 해야 할까요?
 ---
 */

/*:
 ---
 ### Answer
 ---
 */
//giftbot = nil
//tori = nil

// 순서 주의
giftbot.pet = nil
tori.owner = nil

// 아마 잘 됬구나 라고 생각할 수도 있음. 하지만 메모리에 나와있음.
giftbot = nil
tori = nil
//: [Next](@next)
