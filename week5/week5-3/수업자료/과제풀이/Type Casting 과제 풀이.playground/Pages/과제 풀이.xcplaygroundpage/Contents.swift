

/***************************************************
 func addTwoValues(a: Int, b: Int) -> Int {
   return a + b
 }
 
 let task1: Any = addTwoValues(a: 2, b: 3)
 위와 같이 task1 이라는 변수가 있을 때
 task1 + task1 의 결과가 제대로 출력되도록 할 것
 ***************************************************/
func addTwoValues(a: Int, b: Int) -> Int {
  return a + b
}

let task1: Any = addTwoValues(a: 2, b: 3)
(task1 as! Int) + (task1 as! Int)

/*:
 ---
 ### 도전 과제
 ---
 */
/***************************************************
 func addTwoValues(a: Int, b: Int) -> Int {
   return a + b
 }

 let task2: Any = addTwoValues
 위와 같이 task2 라는 변수가 있을 때
 task2 + task2 의 결과가 제대로 출력되도록 할 것 (addTwoValues의 각 파라미터에는 2와 3 입력)
 ***************************************************/

let task2: Any = addTwoValues
(task2 as! (Int, Int) -> Int)(2, 3) + (task2 as! (Int, Int) -> Int)(2, 3)



/***************************************************
 class Car {}
 let values: [Any] = [0, 0.0, (2.0, Double.pi), Car(), { (str: String) -> Int in str.count }]
 
 위 values 변수의 각 값을 switch 문과 타입캐스팅을 이용해 출력하기
 ***************************************************/

class Car {}
let values: [Any] = [
  0,
  0.0,
  (2.0, Double.pi),
  Car(),
  { (str: String) -> Int in str.count }
]

for value in values {
  switch value {
  case let integer as Int:
    print("Integer :", integer)
  case let double as Double:
    print("Double :", double)
  case let (x, y) as (Double, Double):
    print("Tuple : (\(x), \(y))")
  case let car as Car:
    print("Car : ", car)
  case let closure as (String) -> Int:
    print("Closure execution result : ", closure("swift"))
  default:
    print("No matching")
  }
}

