//
//  Node.swift
//  LinkedListProblem
//
//  Created by chang sic jung on 02/05/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import Foundation


public class SingleNode {
    public var value: String
    public var next: SingleNode?
    
    init(value: String, next: SingleNode? = nil) {
        self.value = value
        self.next = next
    }
}

