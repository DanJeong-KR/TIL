//
//  FrameExtensions.swift
//  WeatherForecast
//
//  Created by giftbot on 13/06/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit


// MARK: - frame 기반에서 UI 설정하기 쉽게 하기
extension UIView {
  var x: CGFloat {
     // self.x 로 쓰면되
    get { return frame.origin.x }
    set { frame.origin.x = newValue }
  }
  var y: CGFloat {
    get { return frame.origin.y }
    set { frame.origin.y = newValue }
  }
  var width: CGFloat {
    get { return frame.width }
    set { frame.size.width = newValue }
  }
  var height: CGFloat {
    get { return frame.height }
    set { frame.size.height = newValue }
  }
  var origin: CGPoint {
    get { return frame.origin }
    set { frame.origin = newValue }
  }
  var size: CGSize {
    get { return frame.size }
    set { frame.size = newValue }
  }
  var maxX: CGFloat {
    return frame.origin.x + frame.size.width
  }
  var maxY: CGFloat {
    return frame.origin.y + frame.size.height
  }
}
