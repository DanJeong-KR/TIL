//: [Previous](@previous)
/*:
 ---
 # Encapsulation
 ---
 */
/**********
 Q. 캡슐화 적용해보기
 - A가 서울에서 부산까지 여행을 가기로 함
 - A의 현재 위치는 currentLocation 이라는 메서드를 통해서만 확인 가능
 - 부산으로 이동하는 동작(메서드)을 구현하고 위치의 변경은 이 메서드를 통해서만 가능
 - 부산까지 이동하는 도중에 다른 일들을 할 수 있지만 외부에서는 자세한 내용은 알거나 수정하지 못함
**********/
class A {
    
    
    func currentLocation() {
    }
    func goToBusan() {
    }
}

let a = A()
a.currentLocation()
a.goToBusan()
a.currentLocation()




/*:
 ---
 ### Answer
 ---
 */


class B {
    private var location = "서울"
    
    private func doSomething1() {
        print("잠시 휴게소에 들려서 딴짓")
    }
    private func doSomething2() {
        print("한숨 자다 가기")
    }
    
    func currentLocation() {
        print("====")
        print("현재 위치 :", location)
        print("====")
    }
    
    func goToBusan() {
        print("서울을 출발합니다.")
        doSomething1()
        doSomething2()
        print("부산에 도착했습니다.")
        location = "부산"
    }
}

let b = B()
b.currentLocation()
b.goToBusan()
b.currentLocation()



//: [Next](@next)
