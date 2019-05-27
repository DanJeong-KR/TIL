//: [Previous](@previous)
import Foundation
/*:
 # Binding Example
 */

class Person: CustomStringConvertible {
  let name: String
  init(name: String) {
    self.name = name
    print("\(self) has entered a chat room")
  }
  var description: String { return "<Person \(name)>" }
  deinit { print("\(self) has exited!\n") }
}



func withoutBinding() {
  print("\n---------- [ Without Binding ] ----------\n")
  var person = Person(name: "James")
  
  DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    print("- After 2 seconds -")
    print("\(person) is still in a chat room")
  }
  
  person = Person(name: "Doppelganger")
}

withoutBinding()




func binding() {
  print("\n---------- [ Binding ] ----------\n")
  var person = Person(name: "James")
  
  DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [doppelganger = person] in
    print("- After 2 seconds -")
    print("\(doppelganger) is still in a chat room")
  }
  person = Person(name: "Doppelganger")
}

//binding()




func equivalentToBinding() {
  print("\n---------- [ Equivalent to Binding ] ----------\n")
  var person = Person(name: "James")
  
  let doppelganger = person
  DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    print("- After 2 seconds -")
    print("\(doppelganger) is still in a chat room")
  }
  person = Person(name: "Doppelganger")
}

//equivalentToBinding()



//: [Next](@next)
