//
//  ServiceError.swift
//  WeatherForecastAnswer
//
//  Created by chang sic jung on 13/06/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    // 에러 날 것들을 정의해보자.
    case noData
    case clientError
    case invalidStatusCode
    case invalidFormat // 파싱할 때 에러
}
