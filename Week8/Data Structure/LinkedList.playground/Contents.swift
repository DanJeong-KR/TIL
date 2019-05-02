import Foundation


protocol LinkedListStack {
    var size: Int { get }     // 링크드 리스트 시작 지점
    var isEmpty: Bool { get } // 노드가 있는지 여부
    var head: Node? { get }   // 전체 개수
    func push(node: Node)     // 데이터 삽입
    func pop() -> String?     // 데이터 추출
    func peek() -> String?    // 마지막 데이터 확인
}

class Node {
    let value: String
    var next: Node?
    
    init(Value value: String, nextNode node: Node? = nil) {
        self.value = value
        self.next = node
    }
}

class SingleLinkedList: LinkedListStack
{
    var size: Int = 0
    
    var isEmpty: Bool {
        return size == 0
    }
    
    var head: Node? = Node(Value: "header") // 초기 헤더값
    
//    var head: Node?
//
//    init(head: Node?) { // 헤더노드를 지정하며 시작
//        self.head = head
//    }
    
    var tail: Node? = nil

    
    
    func push(node: Node) {
        
        if size == 0 {
            head?.next = node
            tail = head?.next
        }else {
            var currentNode = head
            for _ in 1...size {
                currentNode = currentNode?.next
            }
            currentNode?.next = node
            tail = currentNode?.next
        }
        size += 1
        
    }
    
    func pop() -> String? {
        if size < 1 {
            print(" 더 이상 pop 을 할 수 없습니다.")
            return nil
            
        }else if size == 1 {
            
            let result = tail?.value
            tail = head
            head?.next = nil
            return result
            
            } else { // size 2부터
            
            var currentNode = head
            for _ in 1...size-1 {
                currentNode = currentNode?.next
            }
            
            let result = tail?.value
            tail = currentNode
            currentNode?.next = nil
            
            size -= 1
            return result
        }
    }
    
    func peek() -> String? {
        if size == 0 { return head?.value}
        else { return tail?.value }
    }
}


// 테스트 케이스

let singleLinkedList = SingleLinkedList() // 시작 헤더노드
singleLinkedList.isEmpty
singleLinkedList.peek()

singleLinkedList.push(node: Node(Value: "A"))
singleLinkedList.peek()

singleLinkedList.push(node: Node(Value: "B"))
singleLinkedList.tail?.value
singleLinkedList.tail?.next
singleLinkedList.peek()

singleLinkedList.push(node: Node(Value: "C"))
singleLinkedList.peek()

singleLinkedList.pop()
singleLinkedList.isEmpty



/*
//강사님 답안
 class Node {
 let value: String
 var next: Node?
 
 init(value: String) {
 self.value = value
 }
 }
 
 class SingleLinkedList: LinkedListStack {
 var size = 0
 var isEmpty: Bool { return head == nil }
 
 var head: Node?
 var lastNode: Node? {
 guard var node = head else { return nil }
 while let nextNode = node.next {
 node = nextNode
 }
 return node
 }
 
 func push(node newNode: Node) {
 size += 1
 guard let node = lastNode else { return head = newNode }
 node.next = newNode
 }
 
 func pop() -> String? {
 size = size > 0 ? size - 1 : 0
 guard var node = head else { return nil }
 guard node.next != nil else {
 head = nil
 return node.value
 }
 while let nextNode = node.next {
 guard nextNode.next != nil else {
 node.next = nil
 return nextNode.value
 }
 node = nextNode
 }
 return node.value
 }
 
 func peek() -> String? {
 guard let node = lastNode else { return nil }
 return node.value
 }
 }

 */
