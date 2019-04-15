//
//  TableViewNumbers.swift
//  TableViewPractice
//
//  Created by 이봉원 on 10/04/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

final class TableViewNumbers: UIViewController {
  
  /***************************************************
   1부터 50까지의 숫자 출력하기
   ***************************************************/
  
  override var description: String {
    return "Practice 1 - Numbers"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let tableView = UITableView(frame: view.frame)
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell2")
    
    view.addSubview(tableView)
  }
}

extension TableViewNumbers: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell: UITableViewCell
//
//        if let resuableCell = tableView.dequeueReusableCell(withIdentifier: "Cell1") {
//            cell = resuableCell
//        }else {
//            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell1")
//        }
//
//        cell.textLabel?.text = "\(indexPath.row + 1)"
//        return cell
        
        let reusableCell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath)
        
        reusableCell.textLabel?.text = "\(indexPath.row)"
        
        return reusableCell
        
    }
    
}
