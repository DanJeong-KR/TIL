

import Foundation

extension Decodable {
    static func decode(
        from data: Data,
        decoder: JSONDecoder = JSONDecoder()
        ) throws -> Self {
        return try decoder.decode(self, from: data)
    }
    
}

extension Data {
    func decode<T>(
        to target: T.Type,
        decoder: JSONDecoder = JSONDecoder()
        ) throws -> T where T: Decodable {
        return try decoder.decode(target, from: self)
    }
}
