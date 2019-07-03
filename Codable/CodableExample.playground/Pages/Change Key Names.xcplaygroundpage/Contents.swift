//: [Previous](@previous)
import Foundation


// 받는 JSON 데이터의 key 값이 언더바 = > 난 카멜케이스 쓸거잖아
// CodingKey 프로토콜로 key 값 새로 지정할 수 있다 나에게 맞게

let jsonData = """
{
  "user_name": "James",
  "user_email": "abc@xyz.com",
  "gender": "male",
}
""".data(using: .utf8)!


struct User: Decodable {
  let name: String
  let email: String
  let gender: String
  
  private enum CodingKeys: String, CodingKey {
    case name = "user_name"
    case email = "user_email"
    case gender
  }
}


let decoder = JSONDecoder()
let user = try decoder.decode(User.self, from: jsonData)
print(user)


//: [Table of Contents](Contents) | [Previous](@previous) | [Next](@next)
