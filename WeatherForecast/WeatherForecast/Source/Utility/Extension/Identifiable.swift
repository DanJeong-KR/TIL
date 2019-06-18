//
//  Identifiable.swift
//  WeatherForecast
//
//  Created by chang sic jung on 18/06/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import Foundation

// 프로토콜은 형용사형, 그런느낌으로 네이밍한다.

protocol Identifiable {
    static var identifier: String { get }
    
}

extension Identifiable {
    static var identifier: String {
        return String(describing: self)
    }
}
