//
//  UserManager.swift
//  Instagram
//
//  Created by Wi on 03/05/2019.
//  Copyright © 2019 Wi. All rights reserved.
//

import Foundation
import UIKit


// 매니저 클래스 구현 유무는 선택사항입니다.

class UserManager {
    static let shared = UserManager()
    private var userData = User(nikName: "", profileImage: UIImage(named: "profile3"))
    
    private init() { }
    
    func getUserData () -> User {
        return userData
    }
    
    func setUserData(user: User) -> () {
        self.userData = user
    }
    
    func setUserNickName(nickName: String) -> () {
        self.userData.nikName = nickName
    }
    
    func setUserProfileImage(profileImage: UIImage) -> () {
        self.userData.profileImage = profileImage
    }
}
