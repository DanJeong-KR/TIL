import Foundation

/*
 더블 링크드 리스트
 
 [ 프로퍼티 ]
 private var head: Node?
 private weak var tail: Node?
 var isEmpty: Bool
 var first: Node?
 var last: Node?
 var count: Int
 
 [ 메서드 ]
 scanValues()  - 현재 저장된 모든 노드의 값 출력
 removeAll()   - 모든 노드 제거
 removeNode(by value: String) -> Bool      - 밸류를 이용해 노드 제거 후 성공 여부
 removeNode(at index: Int) -> String?      - 인덱스를 이용해 노드 제거 후 삭제한 노드의 밸류 반환
 node(by value: String) -> Node?           - 지정한 값을 지닌 노드를 찾아 반환
 insert(node newNode: Node, at index: Int) - 특정 위치에 노드 삽입
 append(node: Node)                        - 마지막 부분에 노드 삽입
 */

class DoubleLinkedList {
    var count: Int = 0
    
    var isEmpty: Bool {
        return head == nil
    }
    
    private var head: DoubleNode?
    private var tail: DoubleNode?
    
    var first: DoubleNode? {
        guard head != nil else { return nil }
        return head
    }
    var last: DoubleNode? {
        guard tail != nil else { return nil }
        return tail
    }
    
    func scanValues() {
        if head == nil { print("비어있는 리스트 입니다.") }
        else {
            var resultStr = ""
            var currentNode = head
            
            while currentNode != nil {
                resultStr += "\(currentNode?.value) - "
                currentNode = currentNode?.next

            }
            print(resultStr)
        }
    }
    
    func append(node: DoubleNode) {
        if isEmpty {
            head = node
            tail = node
        }else {
            nodeSearch(at: count - 1)?.next = node
            node.pre = nodeSearch(at: count - 1)
            tail = node
        }
        count += 1
    }
    
    func insert(node newNode: DoubleNode, at index: Int) {
        newNode.next = nodeSearch(at: index)
        newNode.pre = nodeSearch(at: index - 1)
        nodeSearch(at: index - 1)?.next = newNode
        nodeSearch(at: index)?.pre = newNode
        
        count += 1
    }
    
    func removeAll() {
        if head != nil {
            tail = last?.pre
            
            var currentNode = tail
            while let current = currentNode?.pre {
                currentNode? = current
                currentNode?.next = nil
            }
            
            currentNode = nil
            tail = nil
            head = nil
        }
        count = 0
    }
    
    func removeNode(by value: String) -> Bool {
        
        
        
        var currentNode = head
        var currentIndex = 0
        
        if currentNode?.value == value {
            removeNode(at: currentIndex)
            return true
        }
        
        
        while currentNode != nil {
            currentNode = currentNode?.next
            currentIndex += 1
            if currentNode?.value == value {
                removeNode(at: currentIndex)
                return true
            }
        }
        
        return false
    }
    
    
    func removeNode(at index: Int) -> String? {
        guard head != nil && index <= count - 1 else { print("리스트가 비어있거나 옳지 않은 index"); return nil }
        if index == 0 && count >= 1 { head = first?.next }
        if index == count - 1 { tail = last?.pre }
        let temp = nodeSearch(at: index)?.value
        nodeSearch(at: index - 1)?.next = nodeSearch(at: index + 1)
        nodeSearch(at: index + 1)?.pre = nil
        nodeSearch(at: index + 1)?.pre = nodeSearch(at: index - 1)
        
        count -= 1
        return temp
        
    }
    
    
    func nodeSearch(at index: Int) -> DoubleNode? {
        var currentNode = head
        var currentIndex = 0
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode?.next
            currentIndex += 1
        }
        return currentNode
    }
}
