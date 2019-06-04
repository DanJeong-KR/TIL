//: [Previous](@previous)
/*:
 # JSON
 */
import Foundation

struct MacBook: Codable {
  let model: String
  let modelYear: Int
  let display: Int
}

let macBook = MacBook(
  model: "MacBook Pro", modelYear: 2018, display: 15
)

// Codable 이전 - JSONSerialization
// Codable 이후 - JSONEncoder / JSONDecoder

/*:
 ---
 ## Encoder
 ---
 */
print("\n---------- [ Encoder ] ----------\n")
let jsonEncoder = JSONEncoder()
let encodedMacBook = try! jsonEncoder.encode(macBook)
print(encodedMacBook)

// JSON파일로 저장
let appSupportDir = FileManager.default.urls(
  for: .applicationSupportDirectory, in: .userDomainMask
  ).first!
let archiveURL = appSupportDir
  .appendingPathComponent("macBookData")
  .appendingPathExtension("json")

try? encodedMacBook.write(to: archiveURL)

/*:
 ---
 ## Decoder
 ---
 */
print("\n---------- [ Decoder ] ----------\n")
let jsonDecoder = JSONDecoder()
if let decodedMacBook = try? jsonDecoder.decode(MacBook.self, from: encodedMacBook) {
  print(decodedMacBook)
}

// 파일에서 불러오기
if let retrievedData = try? Data(contentsOf: archiveURL),
  let decodedMacBook = try? jsonDecoder.decode(MacBook.self, from: retrievedData) {
  print(retrievedData)
  print(decodedMacBook)
}



/***************************************************
 Array
 ***************************************************/
print("\n---------- [ Array ] ----------\n")
let arr = [macBook, macBook, macBook]

let encodedArr = try! jsonEncoder.encode(arr)
try? encodedArr.write(to: archiveURL)

if let decodedArr = try? jsonDecoder.decode([MacBook].self, from: encodedArr) {
  print(decodedArr)
}

if let retrievedData = try? Data(contentsOf: archiveURL),
  let decodedArr = try? jsonDecoder.decode([MacBook].self, from: retrievedData) {
  print(retrievedData)
  print(decodedArr)
}


/***************************************************
 Dictionary
 ***************************************************/
print("\n---------- [ Dictionary ] ----------\n")
let dict = ["mac": macBook, "mac1": macBook, "mac2": macBook]

let encodedDict = try! jsonEncoder.encode(dict)
try? encodedDict.write(to: archiveURL)

if let decodedDict = try? jsonDecoder.decode([String: MacBook].self, from: encodedDict) {
  print(decodedDict)
}

if let retrievedData = try? Data(contentsOf: archiveURL),
  let decodedDict = try? jsonDecoder.decode([String: MacBook].self, from: retrievedData) {
  print(retrievedData)
  print(decodedDict)
}


//: [Table of Contents](Contents) | [Previous](@previous) | [Next](@next)
