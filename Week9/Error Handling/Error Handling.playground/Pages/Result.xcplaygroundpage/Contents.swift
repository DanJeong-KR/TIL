//: [Previous](@previous)
import Foundation
/*:
 ---
 # Result
 - Swift 5.0 에서 추가
 ---
 */
enum NetworkError: Error {
  case badUrl
  case missingData
}

/***************************************************
 enum Result<Success, Failure> where Failure : Error {
   case success(Success)
   case failure(Failure)
 }
 ***************************************************/

func downloadImage(from urlString: String, completionHandler: @escaping (Result<String, NetworkError>) -> Void)  {
  guard let url = URL(string: urlString) else {
    return completionHandler(.failure(.badUrl))
  }
  print("Download image from \(url)")
  
  let downloadedImage = "Dog"
//  let downloadedImage = "Missing Data"
  
  if downloadedImage == "Missing Data" {
    return completionHandler(.failure(.missingData))
  } else {
    return completionHandler(.success(downloadedImage))
  }
}


let url = "https://loremflickr.com/320/240/dog"
//let url = "No Image Url"


downloadImage(from: url) { reuslt in
    
}


downloadImage(from: url) { result in
  switch result {
  case .success(let data):
    print("\(data) image download complete")
  case .failure(let error):
    print(error.localizedDescription)
    //  case .failure(.badUrl): print("Bad URL")
    //  case .failure(.missingData): print("Missing Data")
  }
}


downloadImage(from: url) { result in
  if let data = try? result.get() {
    print("\(data) image download complete")
  }
}



//: [Next](@next)
