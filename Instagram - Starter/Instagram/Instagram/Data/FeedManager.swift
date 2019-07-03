//
//  FeedManager.swift
//  Instagram
//
//  Created by Wi on 24/04/2019.
//  Copyright © 2019 Wi. All rights reserved.
//

import Foundation
import UIKit

class FeedManager {
    
    static var shared = FeedManager()
    
    private init() { }
    
    private var feedDatas: [FeedData] = [FeedData(profileImage: nil, nikName: nil, feedImage: UIImage(named: "feedImage2"), myStory: "gggg")]
    
    func getFeedDatas() -> [FeedData] {
        return feedDatas
    }
    
    func addFeedDatas(_ feedData: FeedData) {
        feedDatas.append(feedData)
    }
    
    
}
