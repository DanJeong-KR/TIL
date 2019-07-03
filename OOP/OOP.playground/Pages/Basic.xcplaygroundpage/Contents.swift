//: [Previous](@previous)
/*:
 # Class
 */
/***************************************************
 Value Type => struct, enum  (Stack 에 저장)
 Reference Type => class  (Heap 에 저장)
 ***************************************************/

/***************************************************
 class <#ClassName#>: <#SuperClassName#>, <#ProtocolName...#> {
 <#PropertyList#>
 <#MethodList#>
 }
 
 let <#instanceName#> = <#ClassName()#>
 instanceName.<#propertyName#>
 instanceName.<#functionName()#>
 ***************************************************/


class Dog {
    var color = "White"
    var eyeColor = "Black"
    var height = 30.0
    var weight = 6.0
    
    func sit() {
        print("sit")
    }
    func layDown() {
        print("layDown")
    }
    func shake() {
        print("shake")
    }
}


let bobby: Dog = Dog()
bobby.color
bobby.color = "Gray"
bobby.color
bobby.sit()

let tory = Dog()
tory.color
tory.color = "Brown"
tory.color
tory.layDown()


/*:
 ---
 ### Question
 - 자동차 클래스 정의 및 객체 생성하기
 ---
 */
/***************************************************
 자동차 클래스
 - 속성: 차종(model), 연식(model year), 색상(color) 등
 - 기능: 운전하기(drive), 후진하기(reverse) 등
 ***************************************************/






/*:
 ---
 ### Answer
 ---
 */
class Car {
    let model = "리어카"
    let modelYear = 2016
    let color = "Cream White"
    
    func drive() {
        print("전진")
    }
    func reverse() {
        print("후진")
    }
}

let car = Car()
car.model
car.modelYear
car.color
car.drive()
car.reverse()



//: [Next](@next)
