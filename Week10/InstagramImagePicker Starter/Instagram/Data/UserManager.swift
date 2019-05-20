
import UIKit

class UserManager {
    static let shared = UserManager()
    
    private init() { }
    
    private var userDefaults = UserDefaults.standard
    
    private var user = User(userName: "", profileImage: nil)
    
    
    func getUserInfo(completion: (User) -> ()) {
        completion(self.user)
    }
    
    func changeUserInfo(user: User, completion: (User) -> ()) {
        self.user = user
        
        completion(self.user) // 바뀐 user 를 보내줌.
    }
    
    func changeUserName(userName: String, completion: (Bool,String) -> ()){
        guard let localUserData = userDefaults.array(forKey: "userName"), var userNames = localUserData as? [String] else {
            userDefaults.set([userName], forKey: "userName")
            self.user.userName = userName
            completion(true, userName)
            
            return
        }
        
        if userNames.contains(userName) {
            completion(false, "중복된 닉네임이 있습니다.")
            return
        }
        
        userNames.append(userName)
        userDefaults.set(userName, forKey: "userName")
        self.user.userName = userName
        completion(true, userName)
    }
}
