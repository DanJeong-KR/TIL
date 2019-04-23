//: [Previous](@previous)
/*:
 ---
 ## forEach
 - 컬렉션의 각 요소(Element)에 동일 연산을 적용하며, 반환값이 없는 형태
 ---
 */
print("\n---------- [ forEach ] ----------\n")

let immutableArray = [1, 2, 3, 4]

for num in immutableArray {
  print(num, terminator: " ")
}
print()


immutableArray.forEach { num in
  print(num, terminator: " ")
}
print()


immutableArray.forEach {
  print($0, terminator: " ")
}
print()


func printParam(_ num: Int) {
  print(num, terminator: " ")
}
immutableArray.forEach(printParam(_:))
print()


/*:
 ---
 ### Question
 - forEach 와 for 문의 차이점은?
 - 1~10 까지의 숫자 중 짝수만 출력하다가 9가 되면 종료되도록 forEach를 이용해 구현해본 뒤 for 와 비교하여 설명
 ---
 */



/*:
 ---
 ## map
 - 컬렉션의 각 요소(Element)에 동일 연산을 적용하여, 변형된 새 컬렉션 반환
 ---
 */

print("\n---------- [ Map ] ----------\n")

let names = ["Chris", "Alex", "Bob", "Barry"]
names
  .map { $0 + "'s name" }
  .forEach { print($0) }

let intArr = Array<Int>(repeating: 2, count: 10)
let indexPlusElement = intArr.enumerated().map {
  return $0 + $1
}
print(indexPlusElement)

/*:
 ---
 ## filter
 - 컬렉션의 각 요소를 평가하여 조건을 만족하는 요소만을 새로운 컬렉션으로 반환
 ---
 */
print("\n---------- [ filter ] ----------\n")

// let names = ["Chris", "Alex", "Bob", "Barry"]

let containBNames = names
  .filter { (name) -> Bool in
    return name.contains("B")
  }
print(containBNames)

let countAlexNames = names
  .filter { $0 == "Alex" }
  .count
print(countAlexNames)


/*:
 ---
 ## reduce
 - 컬렉션의 각 요소들을 결합하여 단 하나의 타입을 지닌 값으로 반환.   e.g. Int, String 타입
 ---
 */
print("\n---------- [ reduce ] ----------\n")

/***************************************************
 (1...100)
   .reduce(<#T##initialResult: Result##Result#>, <#T##nextPartialResult: (Result, Int) throws -> Result##(Result, Int) throws -> Result#>)
 initialResult - 초기값
 nextPartialResult - (이전 요소까지의 결과값, 컬렉션이 지닌 현재 요소)
 ***************************************************/

let sum1to100 = (1...100)
  .reduce(0) { (sum: Int, next: Int) in
    return sum + next
  }
print(sum1to100)

//직접 더하는 형태 X
//(1...100).reduce(0) { (sum, next) in
//  sum += next
//}

(1...100)
  .reduce(0) { $0 + $1 }



/*:
 ---
 ### Question
 - 문자열 배열을 reduce를 이용해 하나의 문자열로 합치기
 - 숫자 배열을 reduce를 이용해 하나의 문자열로 합치기
 ---
 */
// 아래 둘 모두 reduce를 이용해 "123" 이라는 문자열이 되도록 만들기
["1", "2", "3"]

[1, 2, 3]



/*:
 ---
 ## compactMap
 - 컬렉션의 요소 중 옵셔널이 있을 경우 제거
 ---
 */
print("\n---------- [ compactMap ] ----------\n")

let optionalStringArr = ["A", nil, "B", nil, "C"]
print(optionalStringArr.compactMap { $0 })


let numbers = [-2, -1, 0, 1, 2]
let positiveNumbers = numbers.compactMap { $0 >= 0 ? $0 : nil }
print(positiveNumbers)



/*:
 ---
 ## flatMap
 - 중첩된 컬렉션을 하나의 컬렉션으로 병합
 ---
 */
print("\n---------- [ flatMap ] ----------\n")

let nestedArr = [[1, 2, 3], [1, 5, 99], [1, 1]]
print(nestedArr.flatMap { $0 })


let nestedArr2 = [[[1,2,3], [4,5,6], [7, 8, 9]], [[10, 11, 12], [13, 14]]]
let flattenNumbers1 = nestedArr2.flatMap { $0 }
print(flattenNumbers1)

let flattenNumbers2 = flattenNumbers1.flatMap { $0 }
print(flattenNumbers2)



/*:
 ---
 ### Question
 - 아래의 배열을 compactMap, flatMap을 쓰지 않고 그와 동일한 결과가 나오도록 구현
 ---
 */
// compactMap
numbers

// flatMap
nestedArr







/*:
 ---
 ### Answer
 ---
 */

print("\n---------- [ A. for vs forEach ] ----------\n")

/***************************************************
 for문은 반복문이므로 break, continue 키워드 사용
 forEach문은 함수(클로져)이므로 break, continue 대신 return 키워드 사용
 ***************************************************/

for i in 1...10 {
  guard i != 9 else { break }
  guard i % 2 == 0 else { continue }
  print(i, terminator: " ")
}
print()

(1...10).forEach {
  guard $0 < 9 else { return }
  guard $0 % 2 == 0 else { return }
  print($0, terminator: " ")
}
print()


print("\n---------- [ A. reduce ] ----------\n")

let merge1 = ["1", "2", "3"].reduce("") { $0 + $1 }
print(merge1)

let merge2 = [1, 2, 3].reduce("") { $0 + String($1) }
print(merge2)

//위 내용을 Full Syntax 로 표현했을 때
//[1, 2, 3]
//  .reduce("") { (str: String, num: Int) in
//    return str + String(num)
//  }






/***************************************************
 compactMap, flatMap 을 쓰지 않고 그와 동일한 동작 구현
 (아래 코드는 실제 swift 내부 구현 방식)
 ***************************************************/
print("\n---------- [ A. compactMap ] ----------\n")

let removeNil = numbers
  .map { $0 >= 0 ? $0 : nil }
  .filter { $0 != nil }
  .map { $0! }
print(removeNil)


print("\n---------- [ A. flatMap ] ----------\n")

nestedArr
  .map { $0 }
  .reduce([], +)

// 실제 swift 내부 구현 코드는 joined 함수를 이용
let flattenArr = nestedArr
  .map { $0 }
  .joined()
print(Array(flattenArr))



//: [Next](@next)
