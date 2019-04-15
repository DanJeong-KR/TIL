

/*:
## Initializer 과제
 1. 생성자 구현
* Vehicle 클래스에 지정 이니셜라이져(Designated Initializer) 추가
* Car 클래스에 modelYear 또는 numberOfSeat가 0 이하일 때 nil을 반환하는 Failable Initializer 추가
* Bus 클래스에 지정 이니셜라이져를 추가하고, maxSpeed를 100으로 기본 할당해주는 편의 이니셜라이져 추가
 
 */
 class Vehicle {
 let name: String
 let maxSpeed: Int
    
    // Designated Initializer
    init(name : String, maxSpeed: Int) {
        self.name = name
        self.maxSpeed = maxSpeed
    }
 }

let testDesignatedInit = Vehicle(name: "changsik", maxSpeed: 20).maxSpeed


 class Car: Vehicle {
 var modelYear: Int
 var numberOfSeats: Int
    
    // failable Initializer 만들기
    init?(modelYear: Int, numberOfSeats: Int) {
        if modelYear <= 0 || numberOfSeats <= 0 {
            return nil
        }
        self.modelYear = modelYear
        self.numberOfSeats = numberOfSeats
        super.init(name: "test", maxSpeed: 10)
        
    }
 }

let testFailInit = Car(modelYear: 4, numberOfSeats: 3)?.numberOfSeats
let testFailInit2 = Car(modelYear: 0, numberOfSeats: 3)?.modelYear




 
 class Bus: Vehicle {
    let isDoubleDecker: Bool
    
//    init(isDoubleDecker: Bool) {
//        self.isDoubleDecker = isDoubleDecker
//        super.init(name: "testCar", maxSpeed: 20)
//    }
    
    init(isDoubleDecker: Bool) {
        self.isDoubleDecker = isDoubleDecker
        super.init(name: "changsic", maxSpeed: 20)
    }
    
    convenience init(test: Bool) {
        self.init(isDoubleDecker: test)
    }

 }

let testConvenienceInit = Bus(test: false).isDoubleDecker



