//: [Previous](@previous)
import Foundation


/***************************************************
 1) 업캐스팅과 다운캐스팅에 대하여 설명하고,
 2) 업캐스팅과 다운캐스팅을 시도할 때 사용하는 키워드에 대해 각각 설명
 ***************************************************/

/*
 업캐스팅과 다운캐스팅 모두 Type Casting 에 해당하는 내용입니다.
 1), 2)
 업 캐스팅은
    - 상속관계에 있는 객체에서 subclass 가 superclass 로 타입을 바꿔서 사용하고 싶을 때 업 캐스팅을 합니다.
    - superclass 로 캐스팅을 할 경우 실패할 가능성이 없기 때문에 as 키워드를 사용합니다.
다운 캐스팅은
    - 상속관계에 있는 객체에서 superclass 가 subclass 로 타입을 바꿔서 사용하고 싶을 때 다운 캐스팅을 합니다.
    - 다운 캐스팅을 할 경우 실패할 가능성이 있기 때문에 as? , as! 키워드를 사용합니다.
 Swift 는
    - 타입을 강제하는 언어이고
    - 자기 자신의 타입에 따라서 컴파일러가 접근할 수 있는 범위가 정해지기 때문에 상속관계에 있는 객체에서 다운 캐스팅을 (as!, as?) 해서 사용해야 하는 경우가 많습니다.
    - Any, AnyObject 타입은 모든 타입을 가질 수 있는 범용 타입이기 때문에 타입 캐스팅이 필연적으로 필요합니다.
 */





/***************************************************
 TableView 아래의 두 메서드가 각각
 1) 언제 사용되고  2) 차이점은 무엇인지에 대하여 작성
 - dequeueReusableCell(withIdentifier:)
 - dequeueReusableCell(withIdentifier:for:)
 ***************************************************/
/*
 
 1) 언제사용?
    - TableView 에서 재사용 매커니즘을 사용하는 셀 객체를 생성할때 사용하는 메소드
 
 2) 차이점?
    - 두 메소드 모두 미리 지정해 놓은 Identifier 에 대한 셀을 얻을 수 있지만
    - dequeueReusableCell(withIdentifier:) 은
        - id 값이 없을 가능성 때문에 Optional 타입으로 반환되서 처리를 해주어야 합니다.
    - dequeueReusableCell(withIdentifier:for:) 은
        - id 값이 없을 가능성을 생각하지 않으므로 cell 타입으로 반환합니다.
        - id 값을 tableview 에 register 메소드로 입력해주지 않을 시에는 런타임 에러가 발생합니다.
 */



/***************************************************
 safeAreaInsets  /  safeAreaLayoutGuide 의 차이점에 대해 작성
 ***************************************************/

/*
 
 애플에서 제공하는 iOS 디자인 가이드에는 safeArea 라는 단어가 존재합니다.
 아이폰 X 시리즈 이상을 예로들면
    - 노치부분의 시간, WiFi 를 표현하는 부분이나
    - 홈 버튼 역할을 하는 아랫부분
 이 개발자가 주의해야 하는 safeArea 라는 개념입니다.
 
 safeAreaInsets 은
    - 설정된 기기의 safeArea 의 frame 값을 나타냅니다.
safeAreaLayoutGuide 는
    - 개발자가 앱에 표현할 UI 에 layout 을 고려할 때 사용하는 객체 입니다.
    - 오토레이아웃 을 사용할 때 NSLayoutAnchor 객체를 사용해야 하는데 safeArea 객체에 대한 NSLayoutAnchor객체를 알려줘서 내가 원하는 객체의 UI의 레이아웃을 safeArea 와 상대적으로 표현할 수 있습니다.
 
 */



/***************************************************
 아래 두 메서드의 공통점과 차이점에 대해 작성
 - init(frame: CGRect)
 - required init?(coder aDecoder: NSCoder)
 ***************************************************/
/*
init(frame: CGRect) 는
    - 객체를 초기화 하는 designated initializer 이며 frame 을 매개변수로 받아 초기 설정을 할 수 있습니다.
 required init?(coder aDecoder: NSCoder) 는
    - required 가 붙은 initializer 는 객체를 생성할 때 반드시 초기화 해야 함을 알려주는 키워드 입니다.
 */


/***************************************************
 Strong Reference Cycle 에 대해 1) 설명하고 2) 예시 코드 작성
 ***************************************************/
/*
 1) 설명
 Swift 에는 ARC (Automatic Reference Counting) 가 존재하며 이는 자동으로 참조를 카운팅하여 메모리를 할당하고 해제하는 것을 컴파일러가 자동으로 해주는 것입니다.
 개발자가 하나하나 reference 를 생각하지 않아도 되면서 매우 편리하고 효율적이지만, 그러다 보니 문제가 발생합니다.
 이 문제가 Strong Reference Cycle 이며 두 객체가 서로를 참조할 때 둘 중 하나의 객체에 reference counting 이 감소하더라도 나머지 하나가 남아있기 때문에 메모리에서 해제되지 않는 현상입니다. 이는 메모리를 leak 하는 문제를 발생시켜서 프로그램을 비효율적으로 만듭니다.
 
 더 이상 사용되지 않거나 외부에서 접근할 수 있는 수단이 없음에도 각 인스턴스가 다른 인스턴스를 지속해서 활성 상태로 만들게 되는 상태를 말한다.
*/

// 2) 예시
class A {
    var temp1:Int = 1
    weak var temp2:B?
    
    deinit { print("A해제") }
}

class B {
    var temp3:Int = 1
    var temp4:A?
    
    init(temp4: A) { self.temp4 = temp4 }
    
    deinit { print("B 해제") }
}

var instanceA:A? = A()
var instanceB:B? = B(temp4: instanceA!)

instanceA?.temp2 = instanceB

instanceA = nil
instanceB = nil

/***************************************************
 Strong, Unowned, Weak 각각의 특징과 차이점에 대해 설명
 ***************************************************/


/*
 Strong 은
    - 컴파일러에게 강한 참조를 알려줍니다.
    - default 값이며 참조가 되면 counting 이 1씩 증가합니다.
 weak 은
    - 약한 참조이며 참조해도 counting 이 늘어나지 않습니다.
    - let 을 사용할 수 없습니다. unowned 와 차이점 입니다.
 unownd 는
    - 미소유 참조이며 참조해도 counting 이 늘어나지 않습니다.
    - let 을 사용할 수 있습니다.
*/
//: [Next](@next)
