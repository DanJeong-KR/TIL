//
//  TableViewCellStyle.swift
//  BasicTableView
//
//  Created by 이봉원 on 10/04/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

final class TableViewCellStyle: UIViewController {
  
  /***************************************************
   셀 스타일 4가지 (default, subtitle, value1, value2)
   ***************************************************/
  
  override var description: String {
    return "TableView - CellStyle"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let tableView = UITableView(frame: view.frame)
    tableView.rowHeight = 70
    tableView.dataSource = self
    view.addSubview(tableView)
  }
}

// MARK: - UITableViewDataSource

extension TableViewCellStyle: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 30
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    // -------------------------- 재사용부분
    let cell: UITableViewCell
    if let defaultCell = tableView.dequeueReusableCell(withIdentifier: "Default"){
      cell = defaultCell
    }else if let subtitleCell = tableView.dequeueReusableCell(withIdentifier: "Subtitle") {
        cell = subtitleCell
    }else if let value1Cell = tableView.dequeueReusableCell(withIdentifier: "Value1") {
        cell = value1Cell
    }else if let value2Cell = tableView.dequeueReusableCell(withIdentifier: "Value2") {
        cell = value2Cell
    }
    // -------------------------- 없는 상태면 새로 만드는 부분.
    else if indexPath.row % 4 == 0 {
      cell = UITableViewCell(style: .default, reuseIdentifier: "Default")
    } else if indexPath.row % 4 == 1 {
        cell = UITableViewCell(style: .value1, reuseIdentifier: "Value1")
    } else if indexPath.row % 4 == 2 {
        cell = UITableViewCell(style: .value2, reuseIdentifier: "Value2")
    }
    else {
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Subtitle")
    }
    
    // 공통 속성 세팅
    cell.textLabel?.text = "\(indexPath.row * 1000)"
    cell.detailTextLabel?.text = "Test"
    cell.imageView?.image = UIImage(named: "bear")
    cell.accessoryType = .detailButton
    
    return cell
  }
}

