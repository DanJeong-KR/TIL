//
//  DominoData.swift
//  DominoPizzaExam
//
//  Created by chang sic jung on 26/04/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import Foundation

final class Pizza {
    var name: String
    var count: Int
    var price: Int
    
    init(PizzaName name: String, Count count: Int,Price price: Int) {
        self.name = name
        self.count = count
        self.price = price
    }
}
