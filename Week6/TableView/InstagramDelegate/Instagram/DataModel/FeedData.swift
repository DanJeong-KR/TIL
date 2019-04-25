//
//  FeedData.swift
//  Instagram
//
//  Created by Wi on 14/04/2019.
//  Copyright © 2019 Wi. All rights reserved.
//

import Foundation
import UIKit

class FeedData {
    let profileImage: String?
    let nickName: String?
    let feedImage: String?
    
    var comment: [String] = ["test"]
    
    let cellInfo: UITableViewCell? = nil
    
    
    init(profileImage: String?, nickName: String?, feedImage: String?) {
        self.profileImage = profileImage ?? AppImageData.profile + "\(1)"
        self.nickName = nickName ?? "NickName"
        self.feedImage = feedImage ?? AppImageData.feedImage + "\(1)"
    }
    
}
