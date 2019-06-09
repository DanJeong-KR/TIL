//: [Previous](@previous)
//: # Versus Serialization
import Foundation

struct Dog: Codable {
  let name: String
  let age: Int
}

/*:
 ---
 ### Question
 - JSONSerialization을 이용해 Dog객체 생성
 - JSONDecoder를 이용해 Dog객체 생성
 ---
 */

/***************************************************
 Basic
 ***************************************************/
print("\n---------- [ Basic ] ----------\n")
let jsonData = """
  {
    "name": "Tory",
    "age": 3,
  }
  """.data(using: .utf8)!

let jsonObject = try? JSONSerialization.jsonObject(with: jsonData)
if let jsonDict = jsonObject as? [String : Any],
    let name = jsonDict["name"] as? String,
    let age = jsonDict["age"] as? Int
{
    let dog = Dog(name: name, age: age)
    print("JSONSerialization 에서 dog : \(dog)")
}

// JSONDecoder
let jsonDecoder = JSONDecoder()
let decoededData = try? jsonDecoder.decode(Dog.self, from: jsonData)
print("JSONDecoder 에서 : ",decoededData!)


// 문제

/***************************************************
 Array
 ***************************************************/

print("\n---------- [ Array ] ----------\n")
let jsonArrData = """
  [
    { "name": "Tory", "age": 3 },
    { "name": "Tory", "age": 3 },
  ]
  """.data(using: .utf8)!

var tempArr: [Dog] = []
// JSONSerialization
let jsonObject = try? JSONSerialization.jsonObject(with: jsonArrData)
if let jsonArr = jsonObject as? [[String : Any]] {
    jsonArr.forEach{
        if let name = $0["name"] as? String,
            let age = $0["age"] as? Int {
            tempArr.append(Dog(name: name, age: age))
        }
    }
}
print("JSONSerialization 로",tempArr)
// JSONDecoder
let decodedJsonData = jsonDecoder.decode([Dog].self, from: jsonArrData)
print(" JSONDecoder 로 ",decodedJsonData)



/***************************************************
 Dictionary
 ***************************************************/

print("\n---------- [ Dictionary ] ----------\n")
let jsonDictData = """
{
  "data": [
    { "name": "Tory", "age": 3 },
    { "name": "Tory", "age": 3 },
  ]
}
""".data(using: .utf8)!

// JSONSerialization
let jsonObject2 = try? JSONSerialization.jsonObject(with: jsonDictData)
if let jsonDic = jsonObject2 as? [String : [[String : Any]]],
    let dataArr = jsonDic["data"] {
    dataArr.forEach {
        if let name = $0["name"] as? String,
            let age = $0["age"] as? Int{
            print("name : \(name) / age : \(age)")
        }
    }
}

// JSONDecoder
let decodedJsonDicData = jsonDecoder.decode([String : [Dog]].self, from: jsonDictData)

print("haha",decodedJsonDicData)









/*:
 ---
 ### Answer
 ---
 */

print("\n---------- [ Answer ] ----------\n")

extension Dog {
  init?(from json: [String: Any]) {
    guard let name = json["name"] as? String,
      let age = json["age"] as? Int
      else { return nil }
    self.name = name
    self.age = age
  }
}

/***************************************************
 Basic
 ***************************************************/
print("---------- [ Basic ] ----------")
// JSONSerialization
if let jsonObject = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any] {
  if let dog = Dog(from: jsonObject) {
    print("Serialization :", dog)
  }
}

// JSONDecoder
if let dog = try? JSONDecoder().decode(Dog.self, from: jsonData) {
  print("Decoder :", dog)
}

/***************************************************
 Array
 ***************************************************/
print("\n---------- [ Array ] ----------")
// JSONSerialization
if let jsonObjects = try? JSONSerialization.jsonObject(with: jsonArrData) as? [[String: Any]] {
  
  jsonObjects
    .compactMap { Dog(from: $0) }
    .forEach { print("Serialization :", $0) }
}

// JSONDecoder
if let dogs = try? JSONDecoder().decode([Dog].self, from: jsonArrData) {
  dogs.forEach { print("Decoder :", $0) }
}


/***************************************************
 Dictionary
 ***************************************************/
print("\n---------- [ Dictionary ] ----------")
// JSONSerialization
if let jsonObject = try? JSONSerialization.jsonObject(with: jsonDictData) as? [String: Any],
  let data = jsonObject["data"] as? [[String: Any]] {
  
  data
    .compactMap { Dog(from: $0) }
    .forEach { print("Serialization :", $0) }
}

// JSONDecoder
if let dogs = try? JSONDecoder().decode([String: [Dog]].self, from: jsonDictData) {
  dogs.values.forEach { $0.forEach { print("Decoder :", $0) } }
}



//: [Table of Contents](@Contents) | [Previous](@previous) | [Next](@next)
