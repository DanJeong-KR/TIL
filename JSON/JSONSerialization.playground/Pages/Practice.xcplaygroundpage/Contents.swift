//: [Previous](@previous)
import Foundation


/***************************************************
 [ 실습1 ]
 다음 주소를 통해 얻은 json 데이터(국제정거장 위치 정보)를 파싱하여 출력하기
 "http://api.open-notify.org/iss-now.json"
 ***************************************************/

func practice1() {
    let locationInfo = "http://api.open-notify.org/iss-now.json"
    let locationApiURL = URL(string: locationInfo)!
    
    let dataTask = URLSession.shared.dataTask(with: locationApiURL) { (data, response, error) in
        
        guard error == nil else { return print(error!) }
        
        guard let response = response as? HTTPURLResponse,
        200..<400 ~= response.statusCode
            else { return print("Status Code 가 부적절하다.")}
        guard let data = data,
            let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any]
            else { return print("No data")}
        //print("jsonObject :",jsonObject)
        
        // 사용할 데이터  파싱
        guard (jsonObject["message"] as? String) == "success",
        let timeStamp = jsonObject["timestamp"],
            let position = jsonObject["iss_position"] as? [String : String],
            let longitude = position["longitude"], //
            let latitude = position["latitude"]
            else { return print(" Parsing Error ")}
        
        print("-------------  1번 ----------------")
        print("timestamp 는 \(timeStamp) 입니다")
        print("longitude 는 \(longitude) 입니다")
        print("latitude 는 \(latitude) 입니다")
    }
    
    dataTask.resume()
}
practice1()


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
    var id: Int
    var firstName: String
    var lastName: String
    var email: String
    
    init?(from json: [String : Any]) { // 이니셜라이저 에서 nil 반환하기
        guard let id = json["id"] as? Int,
            let firstName = json["first_name"] as? String,
            let lastName = json["last_name"] as? String,
            let email = json["email"] as? String
            else { print("Parsing Error"); return nil }
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
}

var userArr: [User] = []

func practice2() {
    let data = jsonString2.data(using: .utf8)!
    do {
        let jsonObject =
            try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        
        if let jsonDict = jsonObject as? [String : Any],
            let users = jsonDict["users"] as? [[String : Any]]
            {
                users.forEach{
                    guard let user = User(from: $0) else { return }
                    userArr.append(user)
                }
        }
    } catch {
        print(error.localizedDescription)
    }
}
practice2()
print("-------------  2번 ----------------")
userArr.forEach{ print($0)}



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

var postArr: [Post] = []

func practice3() {
    let postInfo = "https://jsonplaceholder.typicode.com/posts"
    let postApiURL = URL(string: postInfo)!
    
    let dataTask = URLSession.shared.dataTask(with: postApiURL) { (data, response, error) in
        
        guard error == nil else { return print(error!) }
        
        guard let response = response as? HTTPURLResponse,
            200..<400 ~= response.statusCode
            else { return print("Status Code 가 부적절 합니다")}
        
        // 데이터 파싱
        guard let data = data,
            let jsonObjectArr = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSArray
            else { return print("No data")}
        jsonObjectArr.forEach {
            if let posts = $0 as? [String : Any],
                let userid = posts["userId"] as? Int,
                let id = posts["id"] as? Int,
                let title = posts["title"] as? String,
                let body = posts["body"] as? String
            {
                postArr.append(Post(userId: userid, id: id, title: title, body: body))
            }
        }
        //postArr.forEach{ print($0)}
        print("-------------  3번 ----------------")
        print("전체 개수는 \(postArr.count) 개 ")
        
        // 사용할 데이터  파싱
        
    }
    
    dataTask.resume()
}
practice3()






//: [Table of Contents](Contents) | [Previous](@previous) | [Next](@next)


