//
//  CurrentForecastCell.swift
//  WeatherForecast
//
//  Created by giftbot on 14/06/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

@IBDesignable
final class CurrentForecastCell: UITableViewCell {
  
  private enum UI {
    static let xPadding: CGFloat = 10
    static let yPadding: CGFloat = 6
    static let leftMargin: CGFloat = 16
    static let topMargin: CGFloat = 16
    
    static let weatherImageSize: CGFloat = 40
  }
  
  // MARK: - Properties
  
  private let weatherImageView = UIImageView().then {
    $0.frame = CGRect.make(
      UI.leftMargin, UI.topMargin, UI.weatherImageSize, UI.weatherImageSize
    )
    $0.contentMode = .scaleAspectFit
  }
  private let statusLabel = UILabel().then {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: 24, weight: .light)
  }
  private let tempMinMaxLabel = UILabel().then {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: 22, weight: .light)
  }
  private let currentTempLabel = UILabel().then {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: 120, weight: .ultraLight)
  }
  
  // MARK: - Initializing
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    backgroundColor = .clear
    separatorInset.left = .screenWidth // separatorLine을 화면에 나타나지 않도록 조정 -> 화면 밖으로 밀어내버리는 것.
    contentView.addSubviews(
      weatherImageView, statusLabel, tempMinMaxLabel, currentTempLabel
    )
    
    setupLayout()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  // 값이 모두 정해져있을 경우 init 메서드 내에서 레이아웃 설정 가능
    // 20. 동적으로 잡지 않고 frame 으로 잡기 때문에 init 에서 바로 잡아도 된다.
  func setupLayout() {
    statusLabel.width = .screenWidth
    // 임의로 "1" 이라는 텍스트의 사이즈를 구해서 그 사이즈의 height 값을 status 라벨에 적용시킨것.
    // 이걸 원래 할려면
    // ("1" as NSString).size(withAttributes: [NSAttributedString.Key.font : statusLabel.font!]).height
    // 이 코드를 extension 으로 구현해버림.
    // 레이블에 텍스트가 있는 상태라면 sizeToFit 해버리면 끝남. 레이블에 텍스트가 없는 상태기 때문에 크기 이렇게 잡아준 것.
    
    _ = ("1" as NSString).size(withAttributes: [NSAttributedString.Key.font : statusLabel.font!])
    
    statusLabel.height = "1".size(with: statusLabel.font!).height
    statusLabel.x = weatherImageView.maxX + UI.xPadding
    statusLabel.y = weatherImageView.maxY - statusLabel.height
    
    tempMinMaxLabel.x = weatherImageView.x + UI.xPadding
    tempMinMaxLabel.y = weatherImageView.maxY + UI.yPadding
    tempMinMaxLabel.width = .screenWidth
    tempMinMaxLabel.height = "1".size(with: tempMinMaxLabel.font!).height
    
    currentTempLabel.x = tempMinMaxLabel.x
    currentTempLabel.y = tempMinMaxLabel.maxY - UI.yPadding
    currentTempLabel.width = .screenWidth
    currentTempLabel.height = "1".size(with: currentTempLabel.font!).height
  }
  
  // MARK: - Setup Cell Data
  
    // 21 . 셀 설정하는 configure 기록해놓자.
    // 나는 property 옵저버로 했는데 이게 더 깔끔한 방법인 듯.
    
  func configureCell(
    weatherImageName: String,
    weatherStatus: String,
    minMaxTemp: String,
    currentTemp: String
    ) {
    weatherImageView.image = UIImage(named: weatherImageName)
    statusLabel.text = weatherStatus
    tempMinMaxLabel.text = minMaxTemp
    currentTempLabel.text = currentTemp
  }
}
