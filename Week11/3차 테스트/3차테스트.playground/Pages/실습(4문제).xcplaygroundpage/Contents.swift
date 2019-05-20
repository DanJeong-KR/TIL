import Foundation


 //Output: 손님A이(가) 바리스타A에게 2000원짜리 Americano을(를) 주문하였습니다.


print("\n---------- [ 1번 문제 ] ----------\n")

class Customer {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func order(menu: CoffeeMenu, to barista: Barista) {
        let coffee = barista.makeCoffee(menu: menu)
        print("\(name)가 \(barista.name)에게 \(coffee.price)원짜리 \(menu.rawValue)을(를) 주문하였습니다.")
    }
}

class Barista {
    var name: String
    init(name: String ) {
        self.name = name
    }
    
    func makeCoffee(menu: CoffeeMenu) -> Coffee {
        return Coffee(name: menu.rawValue, price: 2000 )
    }
}

class Coffee {
    var name: String
    var price: Int
    
    init(name: String, price: Int) {
        self.name = name
        self.price = price
    }
}

enum CoffeeMenu: String {
    case americano = "Americano"
    case latte = "Latte"
    case cappuccino = "Cappuccino"
}


let customer = Customer(name: "손님A")
let barista = Barista(name: "바리스타A")
customer.order(menu: .americano, to: barista)

// 손님A이(가) 바리스타A에게 2000원짜리 Americano을(를) 주문하였습니다.


/***************************************************
 < 2번, 3번 문제 >
 ***************************************************/

var data1 = Array(1...100)
var data2 = [0, 3, 9, 15, 27, 33, 41, 49, 90, 98]

/***************************************************
 2번 문제 - Dictionary를 이용해서 구현
 ***************************************************/

print("\n---------- [ 2번 문제 ] ----------\n")

var dict_data1: [Int:[Int]] = [:]
var dict_data2: [Int:[Int]] = [:]

data1.forEach{
    let temp = $0 / 10
    guard dict_data1[temp] != nil else { dict_data1[temp] = [$0]; return }
    dict_data1[temp]?.append($0)
}
data2.forEach {
    let temp = $0 / 10
    guard dict_data2[temp] != nil else { dict_data2[temp] = [$0]; return }
    dict_data2[temp]?.append($0)
}

print("문제 2-1 \n",dict_data1)
print("문제 2-2 \n",dict_data2)




/***************************************************
 3번 문제 - Array를 이용해서 구현
 ***************************************************/

data1 = Array(1...100)
data2 = [0, 3, 9, 15, 27, 33, 41, 49, 90, 98]

print("\n---------- [ 3번 문제 ] ----------\n")

var arr_data1: [[Int]] = Array(repeating: [], count: 11)
var arr_data2: [[Int]?] = Array(repeating: [], count: 11)

data1.forEach {
    let temp = $0 / 10
    arr_data1[temp].append($0)
}

data2.forEach {
    let temp = $0 / 10
    arr_data2[temp]!.append($0)
}

for (idx,value) in arr_data2.enumerated() {
    if value!.isEmpty {
        arr_data2[idx] = nil
    }
}

let result3_2 = arr_data2.compactMap{ $0 }


print("문제 3-1 \n",arr_data1)
print("문제 3-2 \n",result3_2)


// < 4번 문제 > 고차함수만을 이용하여 구현
// 1)
// 1부터 100까지의 숫자를 가진 배열에서 홀수만을 골라 각 숫자에 1씩 더해준 배열을 출력
// Output: [2, 4, 6, 8, 10, 12, ... 98, 100]
//
// 2)
// ["1", "2", "3", "4", "5", "A", "B", "C", "D"]
// 위 배열에서 숫자에 해당하는 문자열만 골라낸 뒤, 그것을 제곱한 숫자들을 모두 더한 결과 출력
// Output: 55


print("\n---------- [ 4번 문제 ] ----------\n")
print("\n---------- [ 4  - 1 ] ----------\n")
let data4_1 = Array(1...100)
let result = data4_1.filter { $0 % 2 == 1 }.map { $0 + 1 }
print(result)

print("\n---------- [ 4  - 2 ] ----------\n")
let data4_2 = ["1", "2", "3", "4", "5", "A", "B", "C", "D"]
print(data4_2.compactMap{ Int($0) }.map{ $0*$0 }.reduce(0, +))

/***************************************************
 수고하셨습니다!
 ***************************************************/



