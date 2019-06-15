//
//  ViewController.swift
//  WeatherForecastAnswer
//
//  Created by chang sic jung on 13/06/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

final class WeatherCasterViewController: UIViewController {
    
    // DI 의존성 주입
    private var forecastService: ForecastServiceType?
    
    // model
    var currentForecast: CurrentForecast?
    
    // 뷰컨트롤러 초기화할때 테스트 할지, API 통신 할지 결정할 수 있다.
    init(forecastService: ForecastServiceType) {
        super.init(nibName: nil, bundle: nil)
        self.forecastService = forecastService
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        forecastService?.fetchShortRangeForecast(
            latitude: 0,
            longitude: 0,
            completionHandler: { (result) in
                switch result {
                case .success(let value):
                    print(value)
                case . failure(let error):
                    print(error.localizedDescription)
                }
        })
    }
    
    func aaaaa() {
        forecastService?.fetchCurrentForecast(
            latitude: 0,
            longitude: 0
        ) { result in
            switch result {
            case .success(let value):
                print(value)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
