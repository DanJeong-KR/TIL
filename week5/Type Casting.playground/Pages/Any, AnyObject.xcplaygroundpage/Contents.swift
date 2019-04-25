//: [Previous](@previous)
/*:
 ---
 # Any , AnyObject
 ---
 */

import Foundation

let num = 0
var intArr = [num, num, num]

let str = "str"
var strArr = [str, str, str]

intArr.append(1)
//intArr.append("1")

strArr.append("1")
//strArr.append(1)


//var someArr = [str, num, str, num]
//type(of: someArr)    // someArr 의 타입은?




var someArr1 = [str, num, str, num] as [Any]
var someArr2: [Any] = [str, num, str, num]



/***************************************************
 Swift 는 Int, String 등의 타입 확정 이후 다른 타입의 값은 비허용.
 단, 예외적으로 적용할 수 있는 가변 타입을 제공
 
 Swift provides two special types for working with nonspecific types:
 - Any can represent an instance of any type at all, including function types.
 - AnyObject can represent an instance of any class type.
 
 Any - 모든 타입
 AnyObject - 모든 클래스 타입
 Any > AnyObject
 ***************************************************/

/*:
 ---
 ### Any
 ---
 */

class SomeClass {}
struct SomeStruct {}

var anyArray: [Any] = [0, "str", true]
type(of: anyArray)

anyArray.append(["key": "value"])
anyArray.append((1, 2, 3, 4))
anyArray.append(SomeClass())
anyArray.append(SomeStruct())
anyArray.append(({(a: Int, b: Int)->(Int) in return a + b}))


/*:
 ---
 ### AnyObject
 ---
 */

class NewClass { var myNumber = 1 }
class AnotherClass {}

var anyObjectArray: [AnyObject] = [SomeClass()]
type(of: anyObjectArray)

anyObjectArray.append(NewClass())
anyObjectArray.append(AnotherClass())
//anyObjectArray.append("newElement")  //
//anyObjectArray.append(SomeStruct())  //



/*:
 ---
 ## Any Type Casting
 ---
 */

//Q. 아래 각 라인을 실행했을 때 결과는?
let anyNum: Any = 5
//var num1: Int = anyNum
//var num2: Int = anyNum as Int   //
//var num3: Int = anyNum as? Int  //
var num4: Int = anyNum as! Int  //




// String 타입의 배열을 사용할 때

type(of: strArr[0])
strArr[0]
strArr[0].count

// Any 타입의 배열을 사용할 때

type(of: anyArray[0])
anyArray[0]
anyArray[0] as! Int + 10
type(of: anyArray)




//: [Next](@next)
