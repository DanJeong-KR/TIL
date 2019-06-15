//
//  UIVIewExtension.swift
//  WeatherForecastAnswer
//
//  Created by chang sic jung on 13/06/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

extension UIView {
    
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
    
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }

    
    // MARK: - frame 기반에서 UI 설정하기 쉽게 한다.
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
    var maxX: CGFloat {
        return x + width
    }
    var maxY: CGFloat {
        return y + height
    }
    var origin: CGPoint {
        get { return frame.origin }
        set { frame.origin = newValue }
    }
    var size: CGSize {
        get { return frame.size }
        set { frame.size = newValue }
    }
}
