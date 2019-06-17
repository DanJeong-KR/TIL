//
//  ServiceError.swift
//  WeatherForecast
//
//  Created by giftbot on 13/06/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import Foundation

enum ServiceError: Error {
  case clientError
  case invalidStatusCode
  case noData
  case invalidFormat // 파싱할 때 에러
}
