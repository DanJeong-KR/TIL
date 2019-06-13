//
//  temp.swift
//  CodableExample
//
//  Created by chang sic jung on 08/06/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import Foundation

struct MacBook: Codable {
    let model: String
    let modelYear: Int
    let display: Int
}

let macBook = MacBook(
    model: "MacBook Pro", modelYear: 2018, display: 15
)

let macbookArr: [MacBook] = [macBook, macBook, macBook]
let macbookDic = ["mac": macBook, "mac1": macBook, "mac2": macBook]


struct Dog: Codable {
    let name: String
    let age: Int
    
    init?(from json: [String : Any]) {
        guard let name = json["name"] as? String,
        let age = json["age"] as? Int
            else { return nil }
        self.name = name
        self.age = age
    }
}

let jsonData = """
  {
    "name": "Tory",
    "age": 3,
  }
  """.data(using: .utf8)!

let jsonArrData = """
  [
    { "name": "Tory", "age": 3 },
    { "name": "Tory", "age": 3 },
  ]
  """.data(using: .utf8)!

let jsonDictData = """
{
  "data": [
    { "name": "Tory", "age": 3 },
    { "name": "gogo", "age": 5 },
  ]
}
""".data(using: .utf8)!



//struct User: Codable {
//    // 내가 정의하는 부분
//    var userName: String
//    var score: Int
//    
//    // 자동 생성하는 부분
//    private enum CodingKeys: String, CodingKey {
//        case userName
//        case score
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        userName = try container.decode(String.self, forKey: .userName) // userName 키값에 대한 객체를 String 으로 decode
//        score = try container.decode(Int.self, forKey: .score)
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(userName, forKey: .userName)
//        try container.encode(score, forKey: .score)
//    }
//}
