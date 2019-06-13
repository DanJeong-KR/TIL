//
//  Extension.swift
//  WeatherForecast
//
//  Created by chang sic jung on 13/06/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

extension UIImageView{
    func addBlurEffect(){
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
}
