//: [Previous](@previous)
/*:
 # ARC Basic
 */

class Person {
  let testCase: String
  init(testCase: String) {
    self.testCase = testCase
  }
  deinit {
    print("\(testCase) is being deinitialized")
  }
}

/*:
 ---
 ### case 1. Allocation & Release
 ---
 */
print("\n---------- [ Case 1 ] ----------\n")

var obj1: Person? = Person(testCase: "case1") // RC 가 1이 되는 시점.
obj1 = nil // RC = 0



/*:
 ---
 ### case 2. 참조 카운트 증가
 ---
 */
print("\n---------- [ Case 2 ] ----------\n")

var obj2: Person? = Person(testCase: "case2") // rc 1
var countUp = obj2 // rc 2 (Person 타입의 인스턴스에 대해)


obj2 = nil // rc 1 되고
countUp = nil // rc 0 이 되서 여기서 deinit


/*:
 ---
 ### case 3. Collection 에 의한 참조 카운트
 ---
 */
print("\n---------- [ Case 3 ] ----------\n")

var obj3: Person? = Person(testCase: "case3") // rc 1
var array = [obj3, obj3] // rc += 1 -> rc 3

obj3 = nil //rc -= 1
array.remove(at: 0) //rc -= 1
array.remove(at: 0) //rc -= 1 -> rc 0



/*:
 ---
 ### case 4. 강한 참조, 약한 참조
 - strong : 기본값. 강한 참조. Reference Count 1 증가
 - unowned : 약한 참조. Count 증가하지 않음. 참조 객체 해제 시에도 기존 포인터 주소 유지
 - weak : 약한 참조. Count 증가하지 않음. 참조하던 객체 해제 시 nil 값으로 변경
 ---
 */

print("\n---------- [ Case 4 ] ----------\n")

var strongObj4 = Person(testCase: "case4") // rc = 1
print(strongObj4)

// 처음부터 weak 이면 rc = 0
// rc = 0  이면 시스템이 쓸모없는 아이라고 판단한다.
// -> nil
weak var weakObj4 = Person(testCase: "case4")
print(weakObj4)

// Person 이라는 메모리를 만들어서 unownedObj4 에 할당을 해줬는데
// unowned 라서 rc = 0 이라서 시스템은 쓸모없는 애니까(rc = 0 이니까) 지워버림
// 근데 unownedObj4 에 할당된 메모리 주소로 가니까 값이 없어. rc = 0 이거든. -> runtime 에러!
//unowned var unownedObj4 = Person(testCase: "case4")
//print(unownedObj4) // 0x1234 -> 아무것도 없는 곳에 주소값을 가지고 있는 것을 Dangling Pointer



/***************************************************
 unowned. weak  -  let , var
 ***************************************************/

// 다음 4줄의 코드 중 사용 불가능한 것은?

unowned let unownedLet = strongObj4 // 0x1234 은 계속 유지하므로 let 써도 됨.
unowned var unownedVar = strongObj4
//weak let weakLet = strongObj4 // 0x1234 -> 에서rc = 0 이 되면 -> nil 로 바뀔 가능성이 있음.
weak var weakVar = strongObj4



 //unowned 와 weak 의 타입은?
print("Unowned type: ", type(of: unownedVar))
print("Weak type: ", type(of: weakVar))



//: [Next](@next)
