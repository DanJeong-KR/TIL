//
//  ForecastType.swift
//  WeatherForecast
//
//  Created by giftbot on 13/06/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import Foundation

// caseIterable 로 allCases 프로퍼티 사용 가능
// ForecastType.allCases 요렇게

// TableView 의 Section 을

enum ForecastType: Int, CaseIterable {
  case current // 0 번째 section
  case shortRange // 1 번째 section
}
