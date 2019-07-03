//: [Previous](@previous)
//: # Value Type Capture
print("\n---------- [ Value Type Capture ] ----------\n")
var a = 1
var b = 2
var c = 10
var result = 0
print("초기 값 :", a, b, c, result)

({
  result = a + b + c
  print("클로저 내부 값 :", a, b, c, result)
})()

b = 4
print("실행 이후 값 :", a, b, c, result)
print()


let valueCapture = { [a, b] in // 별도의 캡처 a, b 는 별도의 변수로 관리됨. 클로져가 만들어진 그 순간을 캡처한다.
  result = a + b + c
  print("클로저 내부 값 :", a, b, c, result)
}
a = 10
b = 10
c = 5
result = a + b + c
print("초기 값 :", a, b, c, result)

valueCapture()
print("실행 이후 값 :", a, b, c, result)


//: # Reference Type Capture
print("\n---------- [ RefType Capture ] ----------\n")

final class RefType {
  var number = 0
}
var x = RefType()
var y = RefType()
print("초기화 값 :", x.number, y.number)

let refCapture = { [x] in
  print("클로저 내부 값 :", x.number, y.number)
}
x.number = 5
y.number = 7
print("변경 값 :", x.number, y.number) // 5, 7

refCapture() // 0, 7 일것 같은데 5,7  = >  주소값을 capture 한다
print("실행 이후 값 :", x.number, y.number) // 5, 7

//: # Binding an arbitrary expression
print("\n---------- [ binding ] ----------\n")
let captureBinding = { [z = x] in
  print(z.number)
}

// reference type 이면 count 올라가지 않게.
let captureWeakBinding = { [weak z = x] in
  print(z?.number ?? 0)
}


let captureUnownedBinding = { [unowned z = x] in
  print(z.number)
}

captureBinding()
captureWeakBinding()
captureUnownedBinding()



/*:
 # Capture Example
 */
print("\n---------- [ Capture Example ] ----------\n")

func makeIncrementer(forIncrement amount: Int) -> () -> Int {
  var runningTotal = 0
  func incrementer() -> Int {
    runningTotal += amount
    return runningTotal
  }
  return incrementer
}

let incrementer = makeIncrementer(forIncrement: 7)
// incrementer 가 살아있는 동안 메모리 공간을 잡고 있음. -> runningTotal 가 캡쳐가 됨
// makeIncrementer 의 반환값이 incrementer 이기 때문에 내부 캡쳐가 살아있음
print(incrementer())
print(incrementer())
print(incrementer())


//: [Next](@next)
