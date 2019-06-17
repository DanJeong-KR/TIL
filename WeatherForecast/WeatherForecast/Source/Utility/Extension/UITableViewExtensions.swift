//
//  UITableViewExtensions.swift
//  WeatherForecast
//
//  Created by giftbot on 14/06/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit
// 프로토콜은 형용사형, 그런느낌으로 네이밍한다.
protocol Identifiable {
  static var identifier: String { get }
}
// MARK: - 셀마다 id 값 셀 이름으로 자동으로 생성되도록
extension Identifiable {
  static var identifier: String {
    return String(describing: self)
  }
}
extension UITableViewCell: Identifiable { }


extension UITableView {
    // UITableViewCell 이 Identifiable 프로토콜 채택하고 있어서 identifier 이 있어서 가능한거지. 제네릭 타입 이라 Identifiable 프로토콜 을 채택하지 않는게 들어올 수 있어서 where 로 지정해주지 않으면 컴파일 에러 난다.
  func register<Cell>(
    cell: Cell.Type,
    forCellReuseIdentifier reuseIdentifier: String = Cell.identifier
    ) where Cell: UITableViewCell {
    // register 할 떄 AnyClass 이므로 identifier 에 class 만 채택할 수 있도록 조건 걸어줬다.
    register(cell, forCellReuseIdentifier: reuseIdentifier)
  }
  
     // dequeue 할 때 as? 안써도 자기 자신의 타입으로 반환하게 해주는 아이.
  func dequeue<Cell>(_ reusableCell: Cell.Type) -> Cell where Cell: UITableViewCell {
    // 여기서는 where Cell: UITableViewCell 에서 Identifiable 프로토콜을 채택시켜도 collectionView 는 dequeue 하는 메소드가 다르기 때문에 collectionView 를 따로 작성해줘야 한다.
    guard let cell = dequeueReusableCell(
      withIdentifier: reusableCell.identifier
      ) as? Cell else { fatalError("Could not find cell with identifier") }
    return cell
  }
}

