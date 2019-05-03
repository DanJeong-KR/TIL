//
//  SingleLinkedList.swift
//  LinkedListProblem
//
//  Created by chang sic jung on 02/05/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import Foundation

protocol LinkedListStack {
    var size: Int { get }
    var isEmpty: Bool { get }
    var head: SingleNode? { get }
    func push(node: SingleNode)
    func pop() -> String?
    func peek() -> String?
}

class SingleLinkedList: LinkedListStack {
    var size: Int = 0
    
    var isEmpty: Bool {
        return head == nil
    }
    
    var head: SingleNode?
    var tail: SingleNode?
    
    
    func push(node: SingleNode) {
        if isEmpty {
            head = node
            tail = node
        }else {
            nodeSearch(at: size - 1)?.next = node
            tail = node
        }
        size += 1
    }
    
    func insert(node newNode: SingleNode, at index: Int) {
        newNode.next = nodeSearch(at: index)
        nodeSearch(at: index - 1)?.next = newNode
        
        size += 1
    }
    
    
    func pop() -> String? {
        tail = nodeSearch(at: size - 2)
        
        let temp = tail?.next?.value
        
        tail?.next = nil
        
        size -= 1
        return temp
    }
    
    func peek() -> String? {
        return tail?.value
        
    }
    
    func nodeSearch(at index: Int) -> SingleNode? {
        var currentNode = head
        var currentIndex = 0
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode?.next
            currentIndex += 1
        }
        return currentNode
    }
}
