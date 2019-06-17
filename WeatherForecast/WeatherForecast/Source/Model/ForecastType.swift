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
enum ForecastType: Int, CaseIterable {
  case current
  case shortRange
}
