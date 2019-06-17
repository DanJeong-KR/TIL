//
//  DecodableExtensions.swift
//  WeatherForecast
//
//  Created by giftbot on 13/06/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import Foundation

extension Decodable {
  static func decode(
    from data: Data,
    decoder: JSONDecoder = JSONDecoder()
    ) throws -> Self {
    return try decoder.decode(self, from: data)
  }
}
