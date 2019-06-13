//
//  ForeCastType.swift
//  WeatherForecastAnswer
//
//  Created by chang sic jung on 13/06/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import Foundation

// caseIterable 로 allCases 프로퍼티 사용 가능
// ForecastType.allCases 요렇게
enum ForecastType: Int, CaseIterable {
    
    case current
    case shortRange
    //case longRange
}

