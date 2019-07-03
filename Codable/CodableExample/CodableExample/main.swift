import Foundation

let jsonDecoder = JSONDecoder()
let jsonEncoder = JSONEncoder()
let pListEncoder = PropertyListEncoder()
let pListDecoder = PropertyListDecoder()

// MARK: - encode
let encodedMacbookData = try! jsonEncoder.encode(macBook)

// MARK: - decode
if let decodedMacbook = try? jsonDecoder.decode(MacBook.self, from: encodedMacbookData) {
    print(decodedMacbook)
}

// MARK: - PropertyList Encoder / Decoder
let encodedMacbookData2 = try pListEncoder.encode(macBook)

let decodedMacbookData2 = try pListDecoder.decode(MacBook.self, from: encodedMacbookData2)

// MARK: - JSON Serialization / JSON Decoder 비교해서 해보기
print("\n---------- [ JSON Serialization / JSON Decoder 비교해서 해보기 ] ----------\n")

print("\n---------- [ 기본형태 JSON Serialization  ] ----------\n")
let jsonObject = try? JSONSerialization.jsonObject(with: jsonData)
if let jsonDict = jsonObject as? [String : Any] {
    
    print(Dog(from: jsonDict))

//    let name = jsonDict["name"] as? String,
//    let age = jsonDict["age"] as? Int {
//    print(Dog(name: name, age: age))
}

print("\n---------- [ 기본형태 JSON Decoder  ] ----------\n")
let decodedJsonObject = try jsonDecoder.decode(Dog.self, from: jsonData)
print(decodedJsonObject)

print("\n---------- [ Array JSON Serialization  ] ----------\n")
let arrJsonObject = try JSONSerialization.jsonObject(with: jsonArrData)
if let arrJson = arrJsonObject as? [[String : Any]] {
    arrJson.forEach {
//        if let name = $0["name"] as? String,
//            let age = $0["age"] as? Int {
//            print(Dog(name: name, age: age))
        print(Dog(from: $0))
    }
}
print("\n---------- [ Array JSON Decoder  ] ----------\n")
let decodedArrJsonObject = try jsonDecoder.decode([Dog].self, from: jsonArrData)
print(decodedArrJsonObject)

print("\n---------- [ Dictionary JSON Serialization  ] ----------\n")
let dicJsonObject = try JSONSerialization.jsonObject(with: jsonDictData)
if let dicJson = dicJsonObject as? [String : Any],
    let arrJson = dicJson["data"] as? [[String : Any]] {
    arrJson.forEach {
//        if let name = $0["name"] as? String,
//            let age = $0["age"] as? Int {
//            print(Dog(name: name, age: age))
//        }
        print(Dog(from: $0))
    }
}

print("\n---------- [ Dictionary JSON Decoder  ] ----------\n")
let decodedDicJsonObject = try jsonDecoder.decode([String : [Dog]].self, from: jsonDictData)
print(decodedDicJsonObject["data"])

// MARK: - Change Key Names
print("\n---------- [ Change Key Names , 키값 내가 원하는 대로 가져오기 ] ----------\n")
let jsonData2 = """
{
"user_name": "James",
"user_email": "abc@xyz.com",
"gender": "male",
}
""".data(using: .utf8)!


struct User: Codable {
    let name: String
    let email: String
    let gender: String
    
    // 자동 완성된 부분을 내가 작성한다.
    private enum CodingKeys: String, CodingKey {
        case name = "user_name"
        case email = "user_email"
        case gender
    }
}

let user = try jsonDecoder.decode(User.self, from: jsonData2)
print(user)

// MARK: - Nested Codable
print("\n---------- [ Nested 데이터 Codable 로 가져오기 ] ----------\n")

let nestedJsonData = """
{
  "message": "success",
  "number": 3,
  "people": [
    { "craft": "ISS", "name": "Anton Shkaplerov" },
    { "craft": "ISS", "name": "Scott Tingle" },
    { "craft": "ISS", "name": "Norishige Kanai" },
  ]
}
""".data(using: .utf8)!


struct Astronauts: Codable {
    let message: String
    let number: Int
    let people: [Person]
    
    struct Person: Codable {
        let craft: String
        let name: String
    }
}

do {
    let astronauts = try jsonDecoder.decode(Astronauts.self, from: nestedJsonData)
    print(astronauts.message)
    print(astronauts.number)
    print(astronauts.people)
} catch {
    print(error.localizedDescription)
}

// MARK: - Nested Keys
print("\n---------- [ Key 가 nested 되어있는 데이터를 가져올 때 ] ----------\n")

let jsonData3 = """
[
  {
    "latitude": 30.0,
    "longitude": 40.0,
    "additionalInfo": {
      "elevation": 50.0
    }
  },
  {
    "latitude": 60.0,
    "longitude": 120.0,
    "additionalInfo": {
      "elevation": 20.0
    }
  }
]
""".data(using: .utf8)!

struct Coordinate: Codable {
    
    var latitude: Double
    var longitude: Double
    // additionalInfo 키값에 정급해서 elevation 을 가져올 것.
    var elevation: Double
    
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case additionalInfo
    }
    
    enum AdditionalInfoKeys: String, CodingKey {
        case elevation
    }
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try value.decode(Double.self, forKey: .latitude)
        longitude = try value.decode(Double.self, forKey: .longitude)
        
        let additionalInfo = try value.nestedContainer(keyedBy: AdditionalInfoKeys.self, forKey: .additionalInfo)
        elevation = try additionalInfo.decode(Double.self, forKey: .elevation)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        
        var additionalInfo = container.nestedContainer(keyedBy: AdditionalInfoKeys.self, forKey: .additionalInfo)
        try additionalInfo.encode(elevation, forKey: .elevation)
    }
}

do {
    let coordinates = try jsonDecoder.decode([Coordinate].self, from: jsonData3)
    coordinates.forEach { print($0) }
} catch {
    print(error.localizedDescription)
}

print("\n---------- [ 중첩 키에 접근안하고 Codable 중첩해서 다시 작성해볼까 ] ----------\n")
struct testCoordinate: Codable {
    var latitude: Double
    var longitude: Double
    var additionalInfo: AdditionalInfo
    
    struct AdditionalInfo: Codable {
        let elevation: Double
    }
}

do {
    let testCoor = try jsonDecoder.decode([testCoordinate].self, from: jsonData3)
    
    testCoor.forEach { print($0) }
} catch {
    print(error.localizedDescription)
}


/***************************************************
 1번 문제
 - 다음 JSON 내용을 Fruit 타입으로 변환
 ***************************************************/
print("\n---------- [ 1번 문제 (Fruits) ] ----------\n")

struct Fruit: Codable {
    let name: String
    let cost: Int
    let description: String?
}

let fruits = try jsonDecoder.decode([Fruit].self, from: jsonFruits)
fruits.forEach{ print($0) }



/***************************************************
 2번 문제
 - 다음 JSON 내용을 Report 타입으로 변환
 ***************************************************/
print("\n---------- [ 2번 문제 (Report) ] ----------\n")

struct Report:Codable {
    let name: String
    let id: String
    let readCount: String
    let reportDate: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case id = "report_id"
        case readCount = "read_count"
        case reportDate = "report_date"
    }
}

let report = try jsonDecoder.decode(Report.self, from: jsonReport)
print(report)


/***************************************************
 3번 문제
 - Nested Codable 내용을 참고하여 다음 JSON 내용을 파싱
 ***************************************************/
print("\n---------- [ 3번 문제 (Movie) ] ----------\n")

struct Person: Decodable {
    let name: String
    let favoriteMovies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case name
        case favoriteMovies = "favorite_movies"
    }
    
    // favoriteMovies 내부의 Movie 부분
    struct Movie: Decodable {
        let title: String?
        let releaseYear: Int?
        
        private enum CodingKeys: String, CodingKey {
            case title
            case releaseYear = "release_year"
        }
    }
}

let persons = try jsonDecoder.decode([Person].self, from: jsonMovie)
print(persons)
persons.first!.favoriteMovies.forEach{ print($0) }


/***************************************************
 4번 문제
 - 다음 URL의 Repository 정보 중에서 다음 속성만을 골라서 데이터 모델로 만들고 출력
 - full_name, description, stargazers_count, forks_count, html_url
 - https://api.github.com/search/repositories?q=user:giftbott
 - 위 URL의 user 부분을 자신의 아이디로 변경
 ***************************************************/

print("\n---------- [ 4번 문제 (Repositories) ] ----------\n")
struct Repositories: Decodable {
    
    let items: [Item]
    
    struct Item: Decodable {
        let fullName: String
        let description: String?
        let stargazersCount: Int
        let forksCount: Int
        let htmlUrl: String
        
        private enum CodingKeys: String, CodingKey {
            case fullName = "full_name"
            case description
            case stargazersCount = "stargazers_count"
            case forksCount = "forks_count"
            case htmlUrl = "html_url"
        }
    }
    
    // JSONSerialization 사용해서 데이터모델 만들 때
    //    init?(from json: [String : Any]) {
    //        guard let fullName = json["full_name"] as? String,
    //        let description = json["description"] as? String,
    //        let stargazersCount = json["stargazers_count"] as? Int,
    //        let forksCount = json["forks_count"] as? Int,
    //        let htmlUrl = json["html_url"] as? String
    //            else { print("데이터 초기화 하는 과정에서 파싱 에러"); return nil }
    //
    //        self.fullName = fullName
    //        self.description = description
    //        self.stargazersCount = stargazersCount
    //        self.forksCount = forksCount
    //        self.htmlUrl = htmlUrl
    //    }
}


func fetchGitHubRepositories() {
    let urlString = "https://api.github.com/search/repositories?q=user:changSic"
    let url = URL(string: urlString)!
    
    let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard error == nil else { return print(error!.localizedDescription)}
        guard let response = response as? HTTPURLResponse,
            (200..<300) ~= response.statusCode,
            response.mimeType == "application/json"
            else { return print("서버 에러 400 혹은 500")}
        guard let data = data else { return print("data안찍") }
        
        do {
            let repositories = try JSONDecoder().decode(Repositories.self, from: data)
            repositories.items.forEach{ print($0) }
        } catch {
            print(error.localizedDescription)
        }
    }
    dataTask.resume()
}


fetchGitHubRepositories()


sleep(5)
print(1)

// 5초
// 1초  
