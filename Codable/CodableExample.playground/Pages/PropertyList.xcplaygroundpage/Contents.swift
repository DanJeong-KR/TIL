//: [Previous](@previous)
/*:
 # PropertyList
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

// Codable 이전 - PropertyListSerialization
// Codable 이후 - PropertyListEncoder / PropertyListDecoder

/*:
 ---
 ## Encoder
 ---
 */
print("\n---------- [ Encoder ] ----------\n")
let pListEncoder = PropertyListEncoder()
let encodedMacBook = try! pListEncoder.encode(macBook)
print(encodedMacBook)

let appSupportDir = FileManager.default.urls(
  for: .applicationSupportDirectory, in: .userDomainMask
  ).first!
let archiveURL = appSupportDir
  .appendingPathComponent("macBookData")
  .appendingPathExtension("plist")

try? encodedMacBook.write(to: archiveURL)


/*:
 ---
 ## Decoder
 ---
 */
print("\n---------- [ Decoder ] ----------\n")
let pListDecoder = PropertyListDecoder()
if let decodedMacBook = try? pListDecoder.decode(MacBook.self, from: encodedMacBook) {
  print(decodedMacBook)
}

if let retrievedData = try? Data(contentsOf: archiveURL),
  let decodedMacBook = try? pListDecoder.decode(MacBook.self, from: retrievedData) {
  print(retrievedData)
  print(decodedMacBook)
}



/*:
 ---
 ### Question
 - MacBook 타입을 Array, Dictionary 형태로 Encoding / Decoding 하려면?
 ---
 */
// 밥먹고  와서 해봐라.

print("\n---------- [ Q. Arr Encoder ] ----------\n")
let Qarr = [macBook, macBook, macBook]
let encodedArrData = try! pListEncoder.encode(Qarr)
print(encodedArrData)

print("\n---------- [ Q. Arr Decoder ] ----------\n")
let decodedArrData = try? pListDecoder.decode([MacBook].self, from: encodedArrData)
print(decodedArrData!)

// dictionary
print("\n---------- [ Q. Dic Encoder ] ----------\n")
let DicArr = ["mac1" : macBook, "mac2" : macBook, "mac3" : macBook]
let encodedDicData = try! pListEncoder.encode(DicArr)
print(encodedDicData)

print("\n---------- [ Q. Dic Decoder ] ----------\n")
let decodedDicData = try? pListDecoder.decode([String : MacBook].self, from: encodedDicData)
print(decodedDicData!)
/*:
 ---
 ### Answer
 ---
 */
// Array
print("\n---------- [ Array ] ----------\n")
let arr = [macBook, macBook, macBook]

let encodedArr = try! pListEncoder.encode(arr)
try? encodedArr.write(to: archiveURL)

if let decodedArr = try? pListDecoder.decode([MacBook].self, from: encodedArr) {
  print(decodedArr)
}

if let retrievedData = try? Data(contentsOf: archiveURL),
  let decodedArr = try? pListDecoder.decode([MacBook].self, from: retrievedData) {
  print(retrievedData)
  print(decodedArr)
}



// Dictionary
print("\n---------- [ Dictionary ] ----------\n")
let dict = ["mac": macBook, "mac1": macBook, "mac2": macBook]

let encodedDict = try! pListEncoder.encode(dict)
try? encodedDict.write(to: archiveURL)

if let decodedDict = try? pListDecoder.decode([String: MacBook].self, from: encodedDict) {
  print(decodedDict)
}

if let retrievedData = try? Data(contentsOf: archiveURL),
  let decodedDict = try? pListDecoder.decode([String: MacBook].self, from: retrievedData) {
  print(retrievedData)
  print(decodedDict)
}


//: [Table of Contents](Contents) | [Previous](@previous) | [Next](@next)
