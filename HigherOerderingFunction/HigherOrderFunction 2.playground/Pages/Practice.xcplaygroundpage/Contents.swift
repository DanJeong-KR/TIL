//: [Previous](@previous)
import Foundation



/*:
 ---
 ## Practice 3
 ---
 */
//let data = [5, 7, 16, 19, 22, 29, 30, 39, 44, 48, 50]

var test: [Int:[Int]] = [:]

test[3] = [3]
test[3]?.append(4)

test[4]?.append(4)

print(test)

var numberCategories:[Int:[Int]] = [:]
let data = Array(0...100)
var dicData = Dictionary<Int,[Int]>()

for i in data {
    let temp = i / 10
    if dicData[temp] != nil {
        dicData[temp]?.append(i)
    }else { // 키값이 없으면 키에 value 할당해서 키 생성하고.
        dicData[temp] = [i]
    }
    
}
print("dicData: ",dicData)

for i in data {
    if let _ = numberCategories[i / 10] {
        numberCategories[i / 10]?.append(i)
    } else {
        numberCategories[i / 10] = [i]
    }
}
print(numberCategories)
//print(dicData)

//: [Next](@next)
