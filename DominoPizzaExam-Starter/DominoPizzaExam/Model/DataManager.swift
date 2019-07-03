//
//  DataManager.swift
//  DominoPizzaExam
//
//  Created by chang sic jung on 26/04/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import Foundation

final class DataManager {
    static var shared = DataManager()
    
    private init() {}
    
    private var pizzaDataDic:[String:[Pizza]] = [:]
    
    func returnData() -> [String:[Pizza]] {
        return pizzaDataDic
    }
    
    func addData(pizzaName: String, pizzaData:Pizza) {
        if let _ = pizzaDataDic[pizzaName] {
            pizzaDataDic[pizzaName]?.append(pizzaData)
        } else {
            pizzaDataDic[pizzaName] = [pizzaData]
        }
    }
    
    func returnPizzaTitle() -> [String] {
        return pizzaDataDic.keys.sorted()
    }
    
    func addCount(pizzaTitle: String, pizzaIndex: Int) {
        pizzaDataDic[pizzaTitle]?[pizzaIndex].count += 1
    }
    func minusCount(pizzaTitle: String, pizzaIndex: Int) {
        pizzaDataDic[pizzaTitle]?[pizzaIndex].count -= 1

    }
    
    func returnCount(pizzaTitle: String ,pizzaIndex: Int) -> Int {
        return pizzaDataDic[pizzaTitle]?[pizzaIndex].count ?? 0
    }
}
