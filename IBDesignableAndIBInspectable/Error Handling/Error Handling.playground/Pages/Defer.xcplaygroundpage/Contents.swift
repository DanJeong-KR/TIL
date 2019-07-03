//: [Previous](@previous)
import Foundation
/*:
 ---
 # Defer
 ---
 */

print("\n---------- [ deferOrder 1 ] ----------\n")

func throwError() throws {
    throw NSError(domain: "Domain", code: 1, userInfo: nil)
}

func deferExample() {

  defer { print("1) First defer") }

  do {
    print("2) Do")
    try? throwError()
  } catch {
    return print("3) Error :", error)
  }
  defer { print("4) Second defer") }
  print("5) Last Print")
}
deferExample()



print("\n---------- [ deferOrder 2 ] ----------\n")

func deferOrder() {
  print("start")
  defer { print("defer1") }
  print("center")
  defer { print("defer2") }
  defer { print("defer3") }
  print("end")
}
deferOrder()


print("\n---------- [ Sum 1...100 ] ----------\n")

func sumOneToHundred() {
  var sum = 0
  var i = 1
  while i <= 100 {
    defer { i += 1 }
    sum += i
  }
  print(sum)
}
sumOneToHundred()


//: [Next](@next)
