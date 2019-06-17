//
//  StringExtensions.swift
//  WeatherForecast
//
//  Created by giftbot on 14/06/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

extension String {
  func size(with font: UIFont) -> CGSize {
    return (self as NSString).size(withAttributes: [.font : font])
  }
}
