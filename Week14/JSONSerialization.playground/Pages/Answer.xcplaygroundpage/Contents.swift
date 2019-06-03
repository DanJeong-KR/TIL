//: [Previous](@previous)
import Foundation

/***************************************************
 [ 실습1 ]
 다음 주소를 통해 얻은 json 데이터(국제정거장 위치 정보)를 파싱하여 출력하기
 "http://api.open-notify.org/iss-now.json"
 ***************************************************/

func practice1() {
  let apiURL = URL(string: "http://api.open-notify.org/iss-now.json")!
  
  let dataTask = URLSession.shared.dataTask(with: apiURL) { (data, response, error) in
    guard let data = data,
      let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
      else { return print("No Data") }
    
    guard let coordinate = jsonObject["iss_position"] as? [String: String],
      let latitude = coordinate["latitude"],
      let longitude = coordinate["longitude"]
      else { return }
    
    print("\n---------- [ 국제 정거장 위치 ] ----------\n")
    print(latitude, longitude)
  }
  dataTask.resume()
}

practice1()


/***************************************************
 [ 실습2 ]
 User 구조체 타입을 선언하고
 다음 Json 형식의 문자열을 User 타입으로 바꾸어 출력하기
 
 e.g.
 User(id: 1, firstName: "Robert", lastName: "Schwartz", email: "rob23@gmail.com")
 User(id: 2, firstName: "Lucy", lastName: "Ballmer", email: "lucyb56@gmail.com")
 User(id: 3, firstName: "Anna", lastName: "Smith", email: "annasmith23@gmail.com")
 ***************************************************/

let jsonString2 = """
{
"users": [
{
"id": 1,
"first_name": "Robert",
"last_name": "Schwartz",
"email": "rob23@gmail.com"
},
{
"id": 2,
"first_name": "Lucy",
"last_name": "Ballmer",
"email": "lucyb56@gmail.com"
},
{
"id": 3,
"first_name": "Anna",
"last_name": "Smith",
"email": "annasmith23@gmail.com"
},
]
}
"""

struct User {
  let id: Int
  let firstName: String
  let lastName: String
  let email: String
  
  init?(from json: [String: Any]) {
    guard let id = json["id"] as? Int,
      let firstName = json["first_name"] as? String,
      let lastName = json["last_name"] as? String,
      let email = json["email"] as? String
      else { print("Parsing error"); return nil }
    
    self.id = id
    self.firstName = firstName
    self.lastName = lastName
    self.email = email
  }
}

func practice2() {
  guard let jsonData = jsonString2.data(using: .utf8),
    let json = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any],
    let userList = json["users"] as? [[String: Any]]
    else { return }
  
  let users: [User] = userList.compactMap {
    guard let user = User(from: $0) else { return nil }
    return user
  }
  
  print("\n---------- [ Users ] ----------\n")
  users.forEach { print($0) }
}

practice2()





/***************************************************
 [ 실습3 ]
 Post 구조체 타입을 선언하고
 다음 주소를 통해 얻은 JSON 데이터를 파싱하여 Post 타입으로 변환한 후 전체 개수 출력하기
 "https://jsonplaceholder.typicode.com/posts"
 ***************************************************/

struct Post {
  let userId: Int
  let id: Int
  let title: String
  let body: String
}

func practice3() {
  let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
  
  let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
    guard let data = data,
      let postList = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]]
      else { return print("No Data") }

    var posts: [Post] = []
    for post in postList {
      guard let userId = post["userId"] as? Int,
        let id = post["id"] as? Int,
        let title = post["title"] as? String,
        let body = post["body"] as? String
        else { continue }
      let post = Post(userId: userId, id: id, title: title, body: body)
      posts.append(post)
    }

    print("\n---------- [ 포스트 ] ----------\n")
    print("총 \(posts.count)개")
  }
  dataTask.resume()
}

practice3()


//: [Next](@next)
