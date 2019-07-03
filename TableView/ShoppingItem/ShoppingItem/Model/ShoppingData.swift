//
//  ShoppingData.swift
//  ShoppingItem
//
//  Created by chang sic jung on 25/04/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import Foundation
import UIKit

class ShoppingData {
    
    let itemImage: UIImage?
    let itemName: String?
    var itemCount: Int = 0
    var stock: Int = 4 
    
    
    init(itemImage: UIImage?, itemName: String?, itemCount: Int) {
        self.itemImage = itemImage
        self.itemName = itemName
        self.itemCount = itemCount
    }
}
