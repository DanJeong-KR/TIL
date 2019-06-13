//
//  ViewController.swift
//  WeatherForecast
//
//  Created by giftbot on 11/06/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    private let blurEffect = UIBlurEffect(style: .dark)
    private lazy var blurEffectView = UIVisualEffectView(effect: blurEffect)
    private let imageView = UIImageView()
    
    // 상단
    lazy private var titleStackView = UIStackView(arrangedSubviews: [titleLocationLabel, titleTimeLabel])
        private let titleLocationLabel = UILabel()
        private let titleTimeLabel = UILabel()
        private let reloadButton = UIButton(type: .system)
    
    // 중간
    private let tableView = UITableView()
    private let tableHeaderView = UIView()
    
    // 하단
    lazy private var bottomStackView = UIStackView(arrangedSubviews: [firstStackView, secondStackView, currentTempLabel])
        lazy private var firstStackView = UIStackView(arrangedSubviews: [weatherImageView, weatherTextLabel])
            private let weatherImageView = UIImageView()
            private let weatherTextLabel = UILabel()
        lazy private var secondStackView = UIStackView(arrangedSubviews: [maxTempLabel, minTempLabel])
            private let maxTempLabel = UILabel()
            private let minTempLabel = UILabel()
        private let currentTempLabel = UILabel()
    
    // 프로퍼티 옵저버들
    private var locationInfo: LocationInfo! {
        didSet {
            let locationStr = self.locationInfo.city + " " + self.locationInfo.county + " " + self.locationInfo.village
            self.titleLocationLabel.text = locationStr
        }
    }
    private var skyInfos = [String]()
    private var tempInfos = [String]()
    
    private var timeRelease: String?
    
    private var currentTemp: String? {
        didSet {
            let convertedStr = changeNumberFormatAndReturnString(numberStr: self.currentTemp) ?? "에러"
            currentTempLabel.text =  convertedStr + "°"
        }
    }
    private var maxTemp: String? {
        didSet {
            let convertedStr = changeNumberFormatAndReturnString(numberStr: self.maxTemp) ?? "에러"
            maxTempLabel.text = "⤒ " + convertedStr + "°"
        }
    }
    private var minTemp: String? {
        didSet {
            let convertedStr = changeNumberFormatAndReturnString(numberStr: self.minTemp) ?? "에러"
            minTempLabel.text = "⤓ " + convertedStr + "°"
        }
    }
    
    // 상태바
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // 아랫쪽 스택뷰 다이나믹 오토레이아웃 잡을 거야
    private var bottomStackViewLeadingConst: NSLayoutConstraint!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        UIconfigures()
        apiProcess()
        layouts()
    }
    
    // MARK: - Configures
    private func UIconfigures() {
        
        blurEffectView.frame = imageView.bounds
        // for supporting device rotation
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0
        imageView.addSubview(blurEffectView)
        
        //imageView 설정
        imageView.image = UIImage(named: "sunny")
        
        // 타이틀 부분
        titleConfigures()
        
        // 아래쪽 온도 스택뷰 부분
        bottomStackViewConfigures()
        
        // 테이블 뷰 부분
        tableConfigures()
        
        view.addSubviews([imageView ,titleStackView,tableView])
        
    }
    
    private func titleConfigures() {
        // stackView 설정
        titleStackView.axis = .vertical
        titleStackView.alignment = .center
        titleStackView.spacing = 0
        titleStackView.addSubview(reloadButton)
        
        // titleLabels 설정
        titleLocationLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLocationLabel.textColor = .white
        
        titleTimeLabel.text = currentTimeGenerator()
        titleTimeLabel.textColor = .white
        titleTimeLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        
        // reloadbutton 설정
        reloadButton.setTitle("↻", for: .normal)
        reloadButton.setTitleColor(.white, for: .normal)
        reloadButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        reloadButton.addTarget(self, action: #selector(reloadDidTapped(_:)), for: .touchUpInside)
        reloadButton.backgroundColor = .clear
    }
    private func tableConfigures(){
        //tableView
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "weatherCell")
        tableView.allowsSelection = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 210, bottom: 0, right: 440 - 290)
        
        // tableHeaderView
        tableHeaderView.backgroundColor = .clear
        //tableHeaderView.frame.size.height = view.frame.height - titleStackView.frame.height
        tableHeaderView.addSubview(bottomStackView)
        tableView.tableHeaderView = tableHeaderView
    }
    private func bottomStackViewConfigures() {
        bottomStackView.axis = .vertical
        bottomStackView.alignment = .leading
        bottomStackView.distribution = .fill
        bottomStackView.spacing = 10
        bottomStackView.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        firstStackView.axis = .horizontal
        firstStackView.alignment = .bottom
        firstStackView.distribution = .fill
        firstStackView.spacing = 10
        
        secondStackView.axis = .horizontal
        secondStackView.alignment = .leading
        secondStackView.distribution = .fill
        secondStackView.spacing = 25
        
        weatherImageView.image = UIImage(named: "SKY_01")
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.widthAnchor.constraint(equalToConstant: 45).isActive = true
        weatherImageView.heightAnchor.constraint(equalTo: weatherImageView.widthAnchor).isActive = true
        weatherTextLabel.text = "맑음"
        weatherTextLabel.font = UIFont.boldSystemFont(ofSize: 23)
        maxTempLabel.text = "⤒ 24.0°"
        maxTempLabel.font = UIFont.systemFont(ofSize: 23, weight: .light)
        minTempLabel.text = "⤓ 13.0°"
        minTempLabel.font = UIFont.systemFont(ofSize: 23, weight: .light)
        currentTempLabel.font = UIFont.systemFont(ofSize: 110, weight: .ultraLight)
        [maxTempLabel, minTempLabel, currentTempLabel, weatherTextLabel].forEach{
            $0.textColor = .white
        }
        
        // MARK: - bottomStackView 레이아웃 리팩토링 필요
        //bottomStackView.frame = CGRect(x: 0, y: 520, width: 400, height: 300)
    }
    
    // MARK: - APIs
    private func apiProcess() {
        let temperatureUrl = URL(string: "https://api2.sktelecom.com/weather/current/hourly?appKey=bd934d80-9cc6-4ecb-a821-b12a8584bd5e&lat=37.11776&lon=127.09776")!
        let hourlyUrl = URL(string: "https://api2.sktelecom.com/weather/forecast/3days?appKey=bd934d80-9cc6-4ecb-a821-b12a8584bd5e&lat=37.11776&lon=127.09776")!
        
        temperatureDataProcess(url: temperatureUrl)
        hourlyDataProcess(url: hourlyUrl)
    }
    private func temperatureDataProcess(url: URL) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                let jsonObject = try? JSONSerialization.jsonObject(with: data),
                let weatherDic = jsonObject as? [String : Any],
                let weather = weatherDic["weather"] as? [String : Any],
                let hourly = weather["hourly"] as? [[String : Any]],
                let temp = hourly.first!["temperature"] as? [String: String],
                let sky = hourly.first!["sky"] as? [String : String]
                else { return print("json 파싱 에러") }


            DispatchQueue.main.async {
                self.currentTemp = temp["tc"]
                self.maxTemp = temp["tmax"]
                self.minTemp = temp["tmin"]
                self.weatherTextLabel.text = sky["name"]
                self.weatherImageView.image = UIImage(named: changeSkyImageCode(imageName: sky["code"]))
            }
        }.resume()
    }
    
    private func hourlyDataProcess(url : URL) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                let weather = try? JSONSerialization.jsonObject(with: data) as? [String : Any],
                let forecast3days = weather["weather"] as? [String : Any],
                let arr = forecast3days["forecast3days"] as? [[String : Any]],
                let forecast = arr.first,
                let grid = forecast["grid"] as? [String : Any],
                let timeRelease = forecast["timeRelease"] as? String,
                let fcst3hour = forecast["fcst3hour"] as? [String : Any],
                let sky = fcst3hour["sky"] as? [String : Any],
                let temperature = fcst3hour["temperature"] as? [String : Any]
                else { return print("data parsing error")}
            
            DispatchQueue.main.async {
                self.locationInfo = LocationInfo(from: grid)
                self.timeRelease = timeRelease
                guard let skyInfosDeop = SkyInfo(from: sky)?.skyArr else { return print("SkyInfo 가 nil 임") }
                self.skyInfos = skyInfosDeop.compactMap{ changeSkyImageCode(imageName: $0) }
                
                guard let tempInfo = TemperatureInfo(from: temperature)?.tempArr else { return print("TemperatureInfo 가 nil 임 ")}
                self.tempInfos = tempInfo.compactMap { $0 }
                
                self.tableView.reloadData()
            }
            
        }.resume()
    
    }
    
    // MARK: - Layouts
    private func layouts() {
        // imageView
        imageView.layout.bottom(equalTo: view.bottomAnchor).leading().trailing().top(equalTo: view.topAnchor)
        // titleStack 부분
        titleStackView.layout.top().leading().trailing()
        reloadButton.layout.top().trailing(constant: -10)
        
        // tableView
        tableView.layout.bottom(equalTo: view.bottomAnchor).leading().trailing().top(equalTo: titleStackView.bottomAnchor)
        
        // bottomStack 부분
        bottomStackView.layout.bottom(constant: -10)
        bottomStackViewLeadingConst = bottomStackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor)
        bottomStackViewLeadingConst.constant = 0
        bottomStackViewLeadingConst.isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableHeaderView.frame.size.height = view.frame.height - titleStackView.frame.height - 30
        bottomStackViewAnimation()
        
    }
    
    private func bottomStackViewAnimation() {
        // MARK: - 왜 되는지 모르곘네 썅
        self.bottomStackViewLeadingConst.constant = 0
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 1,
                       delay: 0,
                       options: .curveEaseInOut,
                       animations: {
                        self.bottomStackViewLeadingConst.constant = -400
                        self.view.layoutIfNeeded()
        })
        
    }
    
    
    
    // MARK: - ActionFuncs
    @objc private func reloadDidTapped(_ sender: UIButton){
        print("reloadDidTapped")
        let skyImages = ["sunny", "lightning", "cloudy", "rainy"].compactMap{ UIImage(named: $0) }
        
        // MARK: - 여기 왜 되는지 모른다.
        self.bottomStackViewLeadingConst.constant = 0
        sender.transform = .identity
        self.view.layoutIfNeeded()
        imageView.alpha = 0.7
        UIView.animate(withDuration: 1) {
            self.imageView.image = skyImages[(0...3).randomElement()!]
            self.imageView.alpha = 1
            self.bottomStackViewLeadingConst.constant = -400
            sender.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
    }

}

// MARK: - Tableview DataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skyInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! TableViewCell
        guard let timeRelease = self.timeRelease else {
            print("cell 부분 timeRelease nil 들어오는 에러")
            return UITableViewCell() }
        
        let date = makeDateLabelStr(inputStr: timeReleaseOptimizer(timeRelease: timeRelease, indexPathRow: indexPath.row))
        let castTime = makeCastTimeLabelStr(inputStr: timeReleaseOptimizer(timeRelease: timeRelease, indexPathRow: indexPath.row))
        
        cell.weather = Weather(date: date,
                               castTime: castTime,
                               weatherImageCode: skyInfos[indexPath.row],
                               temperature: tempInfos[indexPath.row]  )
        
        // MARK: - 스토리보드에서 cell 의 높이를 정할 순 없나?
        tableView.rowHeight = 80
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    // tableView 가 scrollView 를 상속받고 있어서 델리게이트 까지 사용할 수 있구나
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("contentOffset",scrollView.contentOffset)
        
        var convertedAlpha = (scrollView.contentOffset.y * 0.8 / 1118)
        
        if scrollView.contentOffset.y > 1118 {
            convertedAlpha = (1118 * 0.8 / 1118) // 1 ~ 0.2
            blurEffectView.alpha = convertedAlpha
        }
        blurEffectView.alpha = convertedAlpha
    }
}
