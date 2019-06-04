//: [Previous](@previous)
import Foundation

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
