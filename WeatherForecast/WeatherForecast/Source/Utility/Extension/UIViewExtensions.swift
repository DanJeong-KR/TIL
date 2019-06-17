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
  
    // MARK: - 자기가 속해있는 View Controller 를 알 수 있다.
  var parentViewController: UIViewController? {
    var responder: UIResponder? = self
    while let nextResponder = responder?.next {
      responder = nextResponder
        // 건너건너 vc 최 상위의 뷰 다음에 View Controller 가 나오면
      if let vc = nextResponder as? UIViewController {
        return vc
      }
    }
    return nil
  }
}
