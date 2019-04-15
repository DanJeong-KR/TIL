//
//  TableViewCustomCell.swift
//  BasicTableView
//
//  Created by 이봉원 on 11/04/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

final class TableViewCustomCell: UIViewController {
  
  /***************************************************
   커스텀 셀 사용하기
   ***************************************************/
  
  override var description: String {
    return "TableView - CustomCell"
  }
    
  
  let tableView = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.frame = view.frame
    tableView.dataSource = self
    tableView.delegate = self
    tableView.rowHeight = 80
    view.addSubview(tableView)
    
    // 일반적인 셀 등록
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Default")
    // 커스텀 셀 등록
    tableView.register(CustomCell.self, forCellReuseIdentifier: "Custom")
  }
}

// MARK: - UITableViewDataSource

extension TableViewCustomCell: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 20
  }
  
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    //  공통으로 묶을 수 있는 부모 클래스 UITableViewCell 타입 으로 하면 Custom cell 도 담을 수 있다?
    var cell = UITableViewCell()
    
    
    
    // 원하는 조건에 어떤 셀을 사용할 것인지 결정
    if indexPath.row.isMultiple(of: 2) {
         cell = tableView.dequeueReusableCell(withIdentifier: "Custom", for: indexPath)
        let customCell = cell as! CustomCell
        customCell.myLabel.text = "Test"
        customCell.myLabel.textColor = .black
        //customCell.backgroundColor = .yellow
        customCell.myLabel.backgroundColor = .green
    }else {
        cell = tableView.dequeueReusableCell(withIdentifier: "Default", for: indexPath)
    }
    
    cell.textLabel?.text = "\(indexPath.row * 1000)"
    cell.imageView?.image = UIImage(named: "bear")
    
    
    // 이부분의 높이는 44
    // cell for row at  -> UI 설정 전
    // will display cell delegate 메소드 -> UI 설정 후
    // -> will display cell delegate 메소드 에서 UI  설정해줘야함
    // -> cell for row at 은 셀의 UI 를 설정하는 곳이 아니라 기본적인 데이터를 설정하는 부분이다. 이를 잘 구분해야 한다.

    
    return cell
  }
}


// MARK: - UITableViewDelegate

extension TableViewCustomCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // 이부분의 높이는 80
        
       // print("Will Display Cell")
        
//        guard let customCell = cell as? CustomCell else {return}
//        customCell.myLabel.frame = CGRect(x: cell.frame.width - 120, y: 15, width: 100, height: cell.frame.height - 30)
//        
        
    }
}

