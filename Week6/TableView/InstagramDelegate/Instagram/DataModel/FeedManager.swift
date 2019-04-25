
import Foundation
import UIKit

class FeedManager {
    static let shared = FeedManager()
    
    private init () {}
    
    private var allFeedData = [FeedData]()
    // private 로 선언해서  외부에 은닉하기 ( 객체지향 )
    // data 는 은닉하고 함수로만 추가하거나 읽어온다.
    
    func addFeedData(_ feedData: FeedData) {
        allFeedData.append(feedData)
    }
    
    func returnFeedData() -> [FeedData] {
        return allFeedData
    }
}
