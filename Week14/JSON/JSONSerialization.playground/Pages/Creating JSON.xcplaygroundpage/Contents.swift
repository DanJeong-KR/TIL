//: [Previous](@previous)
import Foundation
//: - - -
//: # Creating JSON Data
//: * class func isValidJSONObject(_:) -> Bool
//: * class func writeJSONObject(_:to:options:error:) -> Int
//: * class func data(withJSONObject:options:) throws -> Data
//: - - -

//: ---
//: ## Write JSON Object to OutputStream
//: ---
func writeJSONObjectToOutputStream() {
  let jsonObject = ["hello": "world", "foo": "bar", "iOS": "Swift"]
  guard JSONSerialization.isValidJSONObject(jsonObject) else { return }
  
  let jsonFilePath = "myJsonFile.json" // 파일 이름을 정해두고
    
    // append 는 덮어쓰기 옵션
  let outputJSON = OutputStream(toFileAtPath: jsonFilePath, append: false)!
    
  outputJSON.open() // 파일을 연다 (생성도 자세히 되는지)
  
  let writtenBytes = JSONSerialization.writeJSONObject(
    jsonObject,
    to: outputJSON,
   options: [],
   // options: [.prettyPrinted, .sortedKeys],
    error: nil
  )
  print(writtenBytes)  // 0 = error
  outputJSON.close()
  
  do {
    let jsonString = try String(contentsOfFile: jsonFilePath)
    print(jsonString)
  } catch {
    print(error.localizedDescription)
  }
}

print("\n---------- [ writeJSONObjectToOutputStream ] ----------\n")
writeJSONObjectToOutputStream()

//: ---
//: ## Data with JSON Object
//: ---
private func dataWithJSONObject() {
  let jsonObject: [String: Any] = [
    "someNumber" : 1,
    "someString" : "Hello",
    "someArray"  : [1, 2, 3],
    "someDict"   : [
      "someBool" : true
    ]
  ]
  
  guard JSONSerialization.isValidJSONObject(jsonObject) else { return }
  do {
    let encoded = try JSONSerialization.data(withJSONObject: jsonObject)
    print(encoded)
    
    let decoded = try JSONSerialization.jsonObject(with: encoded)
    if let jsonDict = decoded as? [String: Any] {
      print(jsonDict)
    }
  } catch {
    print(error.localizedDescription)
  }
}

print("\n---------- [ dataWithJSONObject ] ----------\n")
dataWithJSONObject()
//: - - -
//: # Creating a JSON Object
//: * class func jsonObject(with:options:) throws -> Any
//: - - -

//: ---
//: ## JSON Object with Data
//: ---
private func jsonObjectWithData() {
  let jsonString =  """
  {
    "someNumber" : 1,
    "someString" : "Hello",
    "someArray"  : [1, 2, 3, 4],
    "someDict"   : {
      "someBool" : true
    }
  }
  """
  let data = jsonString.data(using: .utf8)!

  do {
    let jsonObject = try JSONSerialization.jsonObject(with: data)
    if let jsonDict = jsonObject as? [String: Any] {
      print(jsonDict)
    }
  } catch {
    print(error.localizedDescription)
  }
}

print("\n---------- [ jsonObjectWithData ] ----------\n")
jsonObjectWithData()



//: ---
//: ## JSON Object with InputStream
//: ---
private func jsonObjectWithInputStream() {
  let jsonFilePath = "myJsonFile.json"
  let inputStream = InputStream(fileAtPath: jsonFilePath)!
  inputStream.open()
  defer { inputStream.close() }
  
  guard inputStream.hasBytesAvailable else { return }
  
  do {
    let jsonObject = try JSONSerialization.jsonObject(with: inputStream)
    print(jsonObject)
  } catch {
    print(error.localizedDescription)
  }
}

print("\n---------- [ jsonObjectWithInputStream ] ----------\n")
jsonObjectWithInputStream()


//: [Next](@next)
