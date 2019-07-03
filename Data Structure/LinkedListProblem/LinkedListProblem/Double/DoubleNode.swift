
import Foundation

public class DoubleNode {
    public var value: String
    public var pre: DoubleNode?
    public var next: DoubleNode?
    
    init(value: String, pre: DoubleNode? = nil, next: DoubleNode? = nil) {
        self.value = value
        self.next = next
        self.pre = pre
    }
}
