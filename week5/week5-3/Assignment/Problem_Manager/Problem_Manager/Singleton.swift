
class Singleton {
    static let shared = Singleton()
    var red: Float = 0.0
    var green: Float = 0.0
    var blue: Float = 0.0
}

let single: Singleton = Singleton.shared
