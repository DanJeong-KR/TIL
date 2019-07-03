//: [Previous](@previous)
import Foundation
/*:
 ---
 # NSError
 ---
 */
func throwNSError() throws {
    // 기본 생성자가 없다. 걍 쓰면됨. // NSError() - 기본 생성자 (X),  Domain cannot be nil
    throw NSError(domain: "Domain error string", code: 99, userInfo: ["MyKey": "MyValue"])
}

func throwsNSErrorExample() {
    do {
        try throwNSError()
    }catch {
        print("Error :",error)
        let e = error as NSError
        print("NSError :",e)
        print("domain :",e.domain)
        print("Code :",e.code)
        print("UserInfo :",e.userInfo)
    }
}
throwsNSErrorExample()




//: [Next](@next)
