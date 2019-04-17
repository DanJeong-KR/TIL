//
//  FeedData.swift
//  Instagram
//
//  Created by Wi on 14/04/2019.
//  Copyright © 2019 Wi. All rights reserved.
//

import Foundation

class FeedData {
    let profileImage: String?
    let nickName: String?
    let feedImage: String?
    
    init(profileImage: String?, nickName: String?, feedImage: String?) {
        self.profileImage = profileImage ?? AppImageData.profile + "\(1)"
        self.nickName = nickName ?? "NickName"
        self.feedImage = feedImage ?? AppImageData.feedImage + "\(1)"
    }
    
}
