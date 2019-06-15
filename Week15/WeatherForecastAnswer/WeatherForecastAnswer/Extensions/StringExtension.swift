//
//  StringExtension.swift
//  WeatherForecastAnswer
//
//  Created by chang sic jung on 13/06/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

extension String {
    func size(with font: UIFont) -> CGSize {
        return (self as NSString).size(withAttributes: [.font : font])
    }
}
