//: [Previous](@previous)
import Foundation

/***************************************************
 4번 문제
 - 다음 URL의 Repository 정보 중에서 다음 속성만을 골라서 데이터 모델로 만들고 출력
 - full_name, description, stargazers_count, forks_count, html_url
 - https://api.github.com/search/repositories?q=user:giftbott
 - 위 URL의 user 부분을 자신의 아이디로 변경
 ***************************************************/

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



