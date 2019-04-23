//: [Previous](@previous)
import Foundation
/*:
 ---
 ## Practice 1
 ---
 */
/***************************************************
 Input : myPet 배열 이용
 
 [ 1번 문제 ]
 Pet 타입의 배열을 파라미터로 받아 그 배열에 포함된 Pet 중
 강아지의 나이만을 합산한 결과를 반환하는 sumDogAge 함수 구현
 func sumDogAge(pets: [Pet]) -> Int
 
 [ 2번 문제 ]
 Pet 타입의 배열을 파라미터로 받아 모든 Pet이 나이를 1살씩 더 먹었을 때의
 상태를 지닌 새로운 배열을 반환하는 oneYearOlder 함수 구현 
 func oneYearOlder(of pets: [Pet]) -> [Pet]
 ***************************************************/
print("\n---------- [ Practice 1 ] ----------\n")

struct Pet {
  enum PetType {
    case dog, cat, snake, pig, bird
  }
  var type: PetType
  var age: Int
}

let myPet = [
  Pet(type: .dog, age: 13),
  Pet(type: .dog, age: 2),
  Pet(type: .dog, age: 7),
  Pet(type: .cat, age: 9),
  Pet(type: .snake, age: 4),
  Pet(type: .pig, age: 5),
]

// 1번
func sumDogAge(pets: [Pet]) -> Int {
  return 0
}
sumDogAge(pets: myPet)

// 2번
func oneYearOlder(of pets: [Pet]) -> [Pet] {
  return []
}
oneYearOlder(of: myPet)



/*:
 ---
 ## Practice 2
 ---
 */
/***************************************************
 let immutableArray = Array(1...40)
 
 [ 문제 ] 
 immutableArray 배열의 각 인덱스와 해당 인덱스의 요소를 곱한 값 중
 홀수는 제외하고 짝수에 대해서만 모든 값을 더하여 결과 출력
 
 단, 아래 1 ~ 3번에 해당하는 함수를 각각 정의하고
 이것들을 조합하여 위 문제의 결과를 도출할 것
 1. 배열의 각 요소 * index 값을 반환하는 함수
 2. 짝수 여부를 판별하는 함수
 3. 두 개의 숫자를 더하여 반환하는 함수
 ***************************************************/
print("\n---------- [ Practice 2 ] ----------\n")




/*:
 ---
 ## Practice 3
 ---
 */
/***************************************************
 let array: [[Int?]] = [[1, 2, 3], [nil, 5], [6, nil], [nil]]
 
 Q. 위 배열이 주어졌을 때 map 과 flatMap, compactMap 을 이용하여 다음 결과를 출력해보세요.
 1. [[Optional(1), Optional(2), Optional(3)], [nil, Optional(5)], [Optional(6), nil], [nil]]
 2. [[1, 2, 3], [5], [6], []] 
 3. [Optional(1), Optional(2), Optional(3), nil, Optional(5), Optional(6), nil, nil] 
 4. [1, 2, 3, 5, 6]
 ***************************************************/
print("\n---------- [ Practice 3 ] ----------\n")

let array: [[Int?]] = [[1, 2, 3], [nil, 5], [6, nil], [nil]]



//: [Next](@next)
