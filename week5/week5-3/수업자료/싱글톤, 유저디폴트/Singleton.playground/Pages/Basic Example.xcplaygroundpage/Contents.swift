//: [Previous](@previous)

class User {
  static let shared = User()
//  private init() {}
  var friends: [Friends] = []
  var blocks: [Friends] = []
}

struct Friends {
  let name: String
}

struct FriendList {
  mutating func addFriend(name: String) {
//    let user = User() // 지역변수이기 때문에 메소드가 끝날때 메모리에서 없어짐. -> User.shared 선언하면 전역변수로 사용할 수 있음.
//    let friend = Friends(name: name)
//    user.friends.append(friend)
    // "원빈", "장동건", "정우성" 3명을 친구로 추가했을 때
    // 최종적으로 user.friends 에 들어있는 friend 의 숫자는?
    
    let user = User.shared
    let friend = Friends(name: name)
    user.friends.append(friend)
    
  }
}

struct BlockList {
  mutating func blockFriend(name: String) {
    let friend = Friends(name: name)
    if let index = User.shared.friends.firstIndex(where: { $0.name == friend.name }) {
      User.shared.friends.remove(at: index) // 원빈이 있는 인덱스 찾기 클로져 활용해서.
    }
    if !User.shared.blocks.contains(where: { $0.name == friend.name }) {
      User.shared.blocks.append(friend)
    }
  }
}

var friendList = FriendList()
friendList.addFriend(name: "원빈")
friendList.addFriend(name: "장동건")
friendList.addFriend(name: "정우성")
//User.shared.friends
let user = User()



var blockList = BlockList()
blockList.blockFriend(name: "원빈")
User.shared.friends
User.shared.blocks

let userInit = User()
userInit.friends
userInit.blocks

let userShared = User.shared
userShared.friends
userShared.blocks



//: [Next](@next)
