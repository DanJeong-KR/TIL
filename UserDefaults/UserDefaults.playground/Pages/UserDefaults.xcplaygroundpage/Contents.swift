//: [Previous](@previous)
import Foundation
/*:
 # UserDefaults
 - iOS 에서 데이터를 파일에 저장하기 위해 사용하는 대표적인 클래스 중 하나
 - 간단한 정보를 저장하고 불러올 때 사용하며 내부적으로 pList 파일로 저장
 */


// Memory
var inMemory = 10
inMemory
/*:
 ---
 ### Question
 - 메모리와 파일로 저장하는 형태의 차이점은?
 ---
 */
// 메모리가 없어지면 없음
// 파일로 저장하면 다시 불러올 수 있음


// UserDefaults 는 일반적으로 싱글톤 형태로 사용
let newUserDefaults = UserDefaults()
let singletonUserDefaults = UserDefaults.standard

// 메모리가 아닌 파일로 저장하는 방식
UserDefaults.standard.set(10, forKey: "Ten")
UserDefaults.standard.integer(forKey: "Ten")

UserDefaults.standard.set(3.14, forKey: "Double Pi")
UserDefaults.standard.set(3.15, forKey: "Double Pi")
UserDefaults.standard.double(forKey: "Double Pi")

UserDefaults.standard.set(true, forKey: "True")
UserDefaults.standard.bool(forKey: "True")

let date = Date()
UserDefaults.standard.set(date, forKey: "Date")
UserDefaults.standard.object(forKey: "Date")

//Q. 저장하지 않은 키를 불러올 때 결과는?
UserDefaults.standard.integer(forKey: "WrongKey") //
UserDefaults.standard.bool(forKey: "WrongKey")    //
UserDefaults.standard.object(forKey: "WrongKey")  //
//



let userDefaults = UserDefaults.standard
print(userDefaults)

print("\n---------- [ dictionaryRepresentation ] ----------\n")
print(userDefaults.dictionaryRepresentation())

print("\n---------- [ keys ] ----------\n")
print(Array(UserDefaults.standard.dictionaryRepresentation().keys))

print("\n---------- [ values ] ----------\n")
print(Array(UserDefaults.standard.dictionaryRepresentation().values))


//: [Next](@next)
