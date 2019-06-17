//
//  UIButtonExtensions.swift
//  WeatherForecast
//
//  Created by giftbot on 14/06/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

// button.addTarget(self, action: #selector(abs(_:)), for: .touchUpInside)
// 에서
// button.addTarget(action: #selector(abs(_:)))
extension UIButton {
  func addTarget(action: Selector) {
    guard let vc = parentViewController else {
      fatalError("addSubview 메서드 호출 이후에 사용해야 함")
    }
    addTarget(vc, action: action, for: .touchUpInside)
  }
}
