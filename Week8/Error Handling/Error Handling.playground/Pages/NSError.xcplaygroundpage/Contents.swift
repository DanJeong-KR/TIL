//: [Previous](@previous)
import Foundation
/*:
 ---
 # NSError
 ---
 */

func throwNSError() throws {
  // NSError() - 기본 생성자 (X),  Domain cannot be nil
  throw NSError(domain: "Domain error string", code: 99, userInfo: ["MyKey": "MyValue"])
}

func throwsNSErrorExample() {
  do {
    try throwNSError()
  } catch {
    print("Error :", error)
    
    let e = error as NSError
    print("NSError :", e)
    print("domain :", e.domain)
    print("code :", e.code)
    print("userInfo :", e.userInfo)
  }
}

throwsNSErrorExample()


//: [Next](@next)
