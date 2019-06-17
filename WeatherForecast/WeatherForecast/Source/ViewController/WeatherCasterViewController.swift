//
//  ViewController.swift
//  WeatherForecast
//
//  Created by giftbot on 13/06/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import CoreLocation
import UIKit

final class WeatherCasterViewController: UIViewController {
  
  private let locationManager = CLLocationManager()
    
    // DI 의존성 주입 (Deffendency ~~어쩌구)  // 여기에 ForecastServiceStub 넣으면 테스트 데이터로 돈다 코드
  private let forecastService: ForecastServiceType = ForecastService()
  private let rootView = WeatherCasterView()
  
    // 8. 현재 시간으로부터 -10 초전 .  stopupdading 헀음에도 한번이 아닌 짧은 시간에 여러번 요청 하지 않도록 하기 위함
  private var lastRequestDate = Date(timeIntervalSinceNow: -10)
    
    // 14. 현재시간이 필요할 때마다 가져오게
  private var now: String {
    get {
        let df = DateFormatter() // PM 12: 47
        df.locale = Locale(identifier: "ko") // Locale 적용 후  -> 오후 12 : 47
        df.dateFormat = "a h:mm"
        return df.string(from: Date())
    }
  }
  
  // model
    
    //22. 첫번쨰 테이블 셀이 현재온도 네!
  private var currentForecast: CurrentForecast? {
    didSet {
      rootView.tableView.alpha = 0
      rootView.tableView.transform = CGAffineTransform(translationX: 500, y: 0)
      UIView.animate(withDuration: 0.4, animations: {
        self.rootView.tableView.alpha = 1
        self.rootView.tableView.transform = .identity
        
        // 해당 섹션만 리로드 하는 것.
        self.rootView.tableView.reloadSections([0], with: .none)
      })
    }
  }
  private var shortRangeForecastList: [ShortRangeForecast]? {
    didSet {
        // 27. 데이터를 받기 전에 흰색 줄이 표시되는 문제 해결하기 위해, 데이터를 받으면 그때 셀 구분선 나타나게 해주려고
      rootView.tableView.separatorStyle = .singleLine
      rootView.tableView.reloadSections([1], with: .automatic)
    }
  }
  
  
  // MARK: - LifeCycle
  
    // 15. 뷰 컨트롤러의 루트 뷰를 설정할떄 호출되는 메소드 loadView 가 있다.
    
  override func loadView() {
    // super.loadView() 이건 루트 뷰에 빈 뷰를 넣는 과정이다
    view = rootView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureLocationManager()
    configureViews()
  }
  
    
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    requestAuthorization()
  }
  
  // MARK: - Setup
  
    // 상태바 없애기
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  private func configureLocationManager() {
    locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
    locationManager.delegate = self // 필요하면 하구
  }
  
  private func configureViews() {
    
    // 18.
    rootView.reloadButton.addTarget(action: #selector(updateWeather(_:)))
    
    // 23. 테이블 뷰 셀 등록하구
    rootView.tableView.register(cell: CurrentForecastCell.self)
    rootView.tableView.register(cell: ShortRangeForecastCell.self)
    rootView.tableView.dataSource = self
    rootView.tableView.delegate = self
  }
  
    
    // 2. 이부분 메모해놓자. presentAlert 도 만들어놓자.
    // 3. 권한 요청하고 infoPlist 에서 Privacy - location when in use 에 내가 사용자에게 보낼 메세지 작성하기 까지
    // 4. 바탕 화면에서 돌아왔을 때 위치 서비스가 계속 요청될 수 있도록 VIew will appear 에 해야 한다는 것
    
  private func requestAuthorization() {
    guard CLLocationManager.locationServicesEnabled() else {
      return presentAlert(message: "앱을 사용하기 위해서는 위치 권한이 필요합니다.")
    }
    switch CLLocationManager.authorizationStatus() {
    case .notDetermined:
      locationManager.requestWhenInUseAuthorization()
    case .restricted, .denied: break
    case .authorizedAlways, .authorizedWhenInUse: break
    default:
      presentAlert(message: "앱을 사용하기 위해서는 위치 권한이 필요합니다.")
    }
  }
  
  
  // MARK: - Action Handler
  
    //19.
  let imageName = ["sunny", "lightning", "cloudy", "rainy"]
  var count = 0
  @objc private func updateWeather(_ sender: UIButton) {
    locationManager.startUpdatingLocation() // 날씨 정보 다시 받아오고
    
    count += 1
    //날씨 상태를 참고해 그에 맞는 이미지를 뿌려줄 수도 있으나 여기서는 단순 교체
    //01:맑음, 02:구름조금, 03:구름많음, 04:구름많고 비, 05:구름많고 눈,
    //06:구름많고 비 또는 눈, 07:흐림, 08:흐리고 비, 09:흐리고 눈, 10:흐리고 비 또는 눈,
    //11:흐리고 낙뢰 12:뇌우/비, 13:뇌우/눈, 14:뇌우/비 또는 눈
    rootView.updateBackgroundImage(imageName: imageName[count % imageName.count])
    
    // 회전 애니메이션
    
    let spinAnimation = CABasicAnimation(keyPath: "transform.rotation") // keyPath 목록 있음
    spinAnimation.duration = 0.5
    spinAnimation.toValue = CGFloat.pi * 2
    sender.layer.add(spinAnimation, forKey: "spinAnimation") // CALayer 에 애니메이션 추가해줌
  }
    
  private func presentAlert(title: String = "알림", message: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "확인", style: .default)
    alertController.addAction(okAction)
    
    if presentedViewController == nil {
      present(alertController, animated: true)
    }
  }
}

// MARK: - CLLocationManagerDelegate

extension WeatherCasterViewController: CLLocationManagerDelegate {
    
    // 5 . delegate 로 위치서비스 허용하면 startUpdatingLocation() 호출하는거 작성해주기
    
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status {
    case .authorizedWhenInUse, .authorizedAlways:
      manager.startUpdatingLocation()
    default: break
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(error.localizedDescription)
  }
  
    // 6. 열로 드어옴
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
    // 위치 정보 여러개 이므로 배열로 들어온다. 그 중 가장 최신 것이 last
    guard let location = locations.last else { return }
    
    // 9. 최소한 5초 이내의 정보만 최신정보로 받을 것임.
    // 캐쉬된 데이터를 막으려고
    guard abs(location.timestamp.timeIntervalSinceNow) < 5 else { return }
    manager.stopUpdatingLocation() // 업데이트 위치 계속 안받으려고 stopUpdating 해주기
    
    let currentDate = Date() // 현재 Date
    
    // 음.. 이해해보자. 2초 ? 적어도 2초가 지났을 때만 요청을 받는다.
    // 최초 1회에 요청 안하고 지나치는 것을 막기 위해 lastRequestDate에  처음 -10초 준것.
    if abs(lastRequestDate.timeIntervalSince(currentDate)) > 2 {
      reverseGeocoding(location: location)
        // 10.
      fetchCurrentForecast(lat: location.coordinate.latitude,
                           lon: location.coordinate.longitude)
      fetchShortRangeForecast(lat: location.coordinate.latitude,
                              lon: location.coordinate.longitude)
      lastRequestDate = currentDate // 업데이트 해주기
    }
  }
  
    // 7. 여기 Location 받아서 Geocoder 로
    
    // 위치 정보 location 을 인자로 받는다.
  private func reverseGeocoding(location: CLLocation) {
    
    let geocoder = CLGeocoder()
    geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
      guard let `self` = self else { return }
      guard error == nil else { return print(error!.localizedDescription) }
      guard let place = placemarks?.first else { return }

      let locality = place.locality ?? "" //  중구
      let subLocality = place.subLocality ?? "" // 신당동
      let thoroughfare = place.thoroughfare ?? "" // 남산대로 / subLocality 로 나타나지 않는 것들이 thoroughfare 속성으로 들어온다.
      let address = locality + " " + (!subLocality.isEmpty ? subLocality : thoroughfare)

      DispatchQueue.main.async {
        // address 에 " " 이 부분 떄문에 address.isEmpty 안나온다. 이 문제 수정해야 함.
        if address.isEmpty {
          self.presentAlert(message: "위치 조회 실패. 다시 시도해주세요.")
        } else {
            // 16. 위치 정보 받으면 뷰에 애니메이션과 함께 위치 값 넣어준다.
          self.rootView.updateTopInfoView(location: address, time: self.now)
        }
      }
    }
  }
  
    // 10.
    
  private func fetchCurrentForecast(lat: Double, lon: Double) {
    forecastService.fetchCurrentForecast(latitude: lat, longitude: lon) {
      [weak self] result in
      DispatchQueue.main.async {
        switch result {
        case .success(let currentForecast):
          self?.currentForecast = currentForecast
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
    }
  }
  // 11.
    
  private func fetchShortRangeForecast(lat: Double, lon: Double) {
    forecastService.fetchShortRangeForecast(latitude: lat, longitude: lon) {
      [weak self] result in
      DispatchQueue.main.async {
        switch result {
        case .success(let value):
            let shortRangeForecastList = value.filter {
                $0.date.timeIntervalSinceNow > 0 // 서버에서 데이터 업데이트가 안됬으면 적절한 데이터가 오지 않는 오류 제거하기.
            }
          self?.shortRangeForecastList = shortRangeForecastList
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
    }
  }
    
    
    
    
    
    
}


// MARK: - UITableViewDataSource
// 24.
extension WeatherCasterViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return ForecastType.allCases.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if ForecastType.current.rawValue == section {
      return currentForecast == nil ? 0 : 1 // 데이터 받은 상태에 따라.
    } else {
        // 기상 예보가 업데이트 되지 않는 문제가 발생했으면
        // 현재 시간보다 그 전의 데이터가 오겠지? 그럼 부적절한 데이터일거야
        // => 현재시간 이후의 데이터가 들어왔을 때에만 데이터에 표현하기
      return shortRangeForecastList?.count ?? 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // CurrentForecastCell
    if ForecastType.current.rawValue == indexPath.section {
      let cell = tableView.dequeue(CurrentForecastCell.self)
      
      if let current = currentForecast {
        // SKY-A01 -> SKY_01
        // 25 .dropFirst 는 String 에서 메소드임. 개꿀이네 기록해놓자.
        let imageName = "SKY_" + current.sky.code.dropFirst(5)
        let status = current.sky.name
        let minTemp = current.temperature.tmin
        let maxTemp = current.temperature.tmax
        let temp = String(current.temperature.tc.dropLast() + "°")
        
        cell.configureCell(
          weatherImageName: imageName,
          weatherStatus: status,
          minMaxTemp: "⤓  \(minTemp.dropLast())°   ⤒  \(maxTemp.dropLast())°",
          currentTemp: temp
        )
      }
      return cell
    }
    else {
      // ShortRangeForecastCell
      let cell = tableView.dequeue(ShortRangeForecastCell.self)
      if let forecast = shortRangeForecastList?[indexPath.row] {
        let df = DateFormatter()
        df.dateFormat = "M.d (E)" // 28 .아 이렇게 뽑으면 되는구나
        let date = df.string(from: forecast.date)
        
        df.dateFormat = "HH:mm"
        let time = df.string(from: forecast.date)
        let imageName = "SKY_" + forecast.skyCode.dropFirst(5)
        
        // 29  소수점 안나오게 하기. %.0f 는 소수점없 / %.1f 소수점 1자리
        // 이거 기록해놓자.
        let temp = String(format: "%.0f°", forecast.temperature)
        cell.configureCell(
          date: date, time: time, imageName: imageName, temperature: temp
        )
      }
      return cell
    }
  }
}


// MARK: - UITableViewDelegate

extension WeatherCasterViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if ForecastType.current.rawValue == indexPath.section {
      return 200
    } else {
      return 80
    }
  }
  
    // 31. 스크롤 뷰 다룰 때 바뀌는 값이 offset 인것 기록.
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let topInset = scrollView.contentInset.top
    let offset = (topInset + scrollView.contentOffset.y) / topInset
    let alpha = 0.8 * (offset > 1 ? 1 : offset)  // 0 ~ 0.8
    
    print("topInset : \(topInset)")
    print("offset : \(offset)")
    print("alpha : \(alpha)")
    rootView.updateBlurView(alpha: alpha)
    
    // 배경이미지 오른쪽으로 살짝 움직이게설정
    let translationX = 30 * (offset > 1 ? 1 : offset)  // 0 ~ 30
    rootView.applyParallaxEffect(translationX: translationX)
  }
}

