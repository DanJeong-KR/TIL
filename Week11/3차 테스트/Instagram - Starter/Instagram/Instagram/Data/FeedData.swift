//
//  FeedData.swift
//  Instagram
//
//  Created by Wi on 14/04/2019.
//  Copyright © 2019 Wi. All rights reserved.
//

import Foundation
import UIKit

// 피드데이터를 만들어보세요.
// 피드데이터가 가지고 있을 데이터는 무엇인지 생각해보세요.
// 피드데이터는 클래스로 만들어졌습니다. 
class FeedData {
    
    var profileImage: UIImage? = UIImage(named: "profile3")
    var nikName: String? = ""
    var feedImage: UIImage?
    var myStory: String?
    var comments: [String?] = ["hihi", "ㅎㅔ헤"]
    
    init(profileImage profileImage: UIImage = UIImage(named: "profile3")!, nikName nikName: String = "", feedImage feedImage: UIImage, myStory myStory: String) {
        self.profileImage = profileImage
        self.nikName = nikName
        self.feedImage = feedImage
        self.myStory = myStory
    }
}
