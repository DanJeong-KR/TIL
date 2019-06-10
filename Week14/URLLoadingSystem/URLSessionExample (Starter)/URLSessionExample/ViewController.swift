//
//  ViewController.swift
//  URLSessionExample
//
//  Created by giftbot on 2019. 6. 6..
//  Copyright © 2019년 giftbot. All rights reserved.
//

import UIKit

let toDoAPIString = "https://jsonplaceholder.typicode.com/todos"

final class ViewController: UIViewController {
  
  @IBOutlet private weak var imageView: UIImageView!
  private let imageUrlStr = "https://loremflickr.com/860/640/cat"
  
  
  // MARK: - Sync method
  
  @IBAction private func syncMethod() {
    print("\n---------- [ syncMethod ] ----------\n")
    
    let url = URL(string: imageUrlStr)!
    
    // Data() 동작이 sync 이므로 이미지 다운로드 될 때까지 다른 작업 할 수 없다.
//    if let data = try? Data(contentsOf: url) {
//        imageView.image = UIImage(data: data)
//    }
    
    // 다른 Thread 에서 처리하도록 하면 동기 문제를 해결 가능하더라
    DispatchQueue.global().async {
        if let data = try? Data(contentsOf: url) {
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data)
            }
        }

    }
    
  }
  
  // MARK: - URLComponents
  @IBAction private func urlComponentsExample(_ sender: Any) {
    print("\n---------- [ urlComponentsExample ] ----------\n")
    
    /***************************************************
     http://username:password@www.example.com:80/index.html?key1=value1&key2=value2#frag
     ***************************************************/
    
    var components = URLComponents()
    components.scheme = "http"
    components.user = "username"
    components.password = "password"
    components.host = "www.example.com"
    components.port = 80
    
    // path 는 '/' 해줘야 해!
    components.path = "/index.html"
    //components.query = "key1=value1&key2=value2"
    components.queryItems = [URLQueryItem(name: "key1", value: "value1"),
                            URLQueryItem(name: "key2", value: "value2")]
    components.fragment = "frag"
    print(components)
    
    // url 다룰 때 자세하게 다룰 수 있다.
    
    var comp = URLComponents(string: "http://username:password@www.example.com:80/index.html?key1=value1&key2=value2#frag")
    comp?.fragment = "testFrag"
    print("변경된 component :", comp!)
    

  }
  
  // MARK: - URL Encoding Example
  
  @IBAction private func urlEncodingExample() {
    print("\n---------- [ urlEncodingExample ] ----------\n")
    
    let urlString = "https://search.naver.com/search.naver?query=iOS"
    if let url = URL(string: urlString) {
        print(url)
    } else {
        print("nil")
    }
    
    // 한글주소를 사용하려면 utf - 8 형식으로 인코딩 해야하는 문제
    // 인코딩 후 요청해야한다.
    // 전체 url 쓸 필요 없고 바꾸려고 하는 글자만 써도 무방. 알파벳은 모두 무시하고 한글만 변환하기 때문에
   
    let urlStringK = "https://search.naver.com/search.naver?query=한글"
    let queryEncodedStr = urlStringK.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    let convertedUrl = URL(string: queryEncodedStr)!
    print("Converted URL :",convertedUrl)
    
    
    // 문자열 안에 # 이 포함하는 경우는 percentEncoding 거쳐야 해.
    
    let originalString = "color-#708090"
    let allowed = CharacterSet.urlQueryAllowed
    let encodedString = originalString.addingPercentEncoding(withAllowedCharacters: allowed)
    print(encodedString!)  // "color-%23708090"
    
    
    
    // 여기 부터
    
    // decoding
    
    let encodedUrlString = "www.example.com/#color-%23708090"
    let url = URL(string: encodedUrlString)!
    let components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
    let fragment = components.fragment!
    print(fragment)
    
    // 문자열 일 떄 decoding
    
  }
  
  
  
  // MARK: - Session Configuration
  @IBAction private func sessionConfig(_ sender: Any) {
    print("\n---------- [ Session Configuration ] ----------\n")
    
    //defualt session
    let sessionConfig = URLSessionConfiguration.default
    
    // wifi 로만 데이터를 다운로드 하게 할 것인지
    sessionConfig.allowsCellularAccess = false
    sessionConfig.httpMaximumConnectionsPerHost = 5
    sessionConfig.timeoutIntervalForRequest = 20
    
    // 기본값 .useprotocolCachePolicy
    sessionConfig.requestCachePolicy = .reloadIgnoringLocalCacheData
    
    // 기본 false 인터넷 연결 안되있을 떄 즉각 실패하지 않고 잠간 기다렸다가 통신할 수 있꼐 하는 속성
    sessionConfig.waitsForConnectivity = true

    let mySession = URLSession(configuration: sessionConfig)
    let url = URL(string: imageUrlStr)!
    let task = mySession.dataTask(with: url) { (data, response, error) in
        guard let data = data else { return }
        DispatchQueue.main.async {
            self.imageView.image = UIImage(data: data)!
            print("download completed")
        }
    }
    task.resume()
  }
  

  // MARK: - Get, Post, Delete
  
  @IBAction func requestGet(_ sender: Any) {
    print("\n---------- [ Get Method ] ----------\n")
    let toDoUrl = URL(string: toDoAPIString + "/1")
    let task = URLSession.shared.dataTask(with: toDoUrl!) { (data, response, error) in
        guard error == nil else { return print(error?.localizedDescription) }
        guard let response = response as? HTTPURLResponse,
        (200..<300) ~= response.statusCode,
        response.mimeType == "application/json"
            else { return print("서버에러 400 혹은 500")}
        
        guard let data = data,
        let todo = try? JSONDecoder().decode(Todo.self, from: data)
            else { return print("데이터에 문제가 발생했습니다.")}
        
        print(todo)
    }
    task.resume()
  }
  
  
  @IBAction func requestPost(_ sender: Any) {
    print("\n---------- [ Post Method ] ----------\n")
    let todoEndpoint = "https://jsonplaceholder.typicode.com/todos"
    guard let url = URL(string: todoEndpoint) else { return print("error : URL 을 생성할 수 없습니다.")}
    
    let newTodo: [String : Any] = [
        "userId" : 1,
        "title" : "My first Todo ",
        "completed" : false ]
    guard let encodedTodo = try? JSONSerialization.data(withJSONObject: newTodo)
        else { return }
    
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "POST"
    urlRequest.httpBody = encodedTodo
    
    let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
        // 정석
        guard error == nil else { return print(error!.localizedDescription) }
        guard let response = response as? HTTPURLResponse,
            (200..<300) ~= response.statusCode,
            response.mimeType == "application/json" // 미리 정해진 타입을 확인할수도 있다~
            else { return print("서버에러 400 혹은 500 ") }
        
        print(response.statusCode)
        
        guard let data = data,
            let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
            else { print("data 가 존재하지 않습니다 . nil 들어왔잖아요 "); return }
        
        print(jsonObject)
        
    }
    task.resume()
  }
  
  
  @IBAction func requestDelete(_ sender: Any) {
    print("\n---------- [ Delete Method ] ----------\n")
    let todoEndpoint = "https://jsonplaceholder.typicode.com/todos/1"
    guard let url = URL(string: todoEndpoint) else { return print("error : URL 을 생성할 수 없습니다.")}
    
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "DELETE"
    
    let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
        // 정석
        guard error == nil else { return print(error!.localizedDescription) }
        guard let response = response as? HTTPURLResponse,
            (200..<300) ~= response.statusCode,
            response.mimeType == "application/json" // 미리 정해진 타입을 확인할수도 있다~
            else { return print("서버에러 400 혹은 500 ") }
        print(response.statusCode)
        //
        guard let data = data,
            let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
            else { print("data 가 존재하지 않습니다 . nil 들어왔잖아요 "); return }
        
        print(jsonObject)
        
    }
    task.resume()
    
    
  }
}

