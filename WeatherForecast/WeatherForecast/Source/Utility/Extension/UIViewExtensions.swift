//
//  UIViewExtensions.swift
//  WeatherForecast
//
//  Created by giftbot on 14/06/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

extension UIView {
  func addSubviews(_ views: UIView...) {
    views.forEach { addSubview($0) }
  }
  
}
