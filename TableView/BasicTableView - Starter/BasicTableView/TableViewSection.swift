//
//  TableView02.swift
//  BasicTableView
//
//  Created by giftbot on 2019. 4. 10..
//  Copyright © 2019년 giftbot. All rights reserved.
//

import UIKit

final class TableViewSection: UIViewController {
  
  /***************************************************
   섹션을 나누어 데이터 목록 출력하기
   ***************************************************/
  
  override var description: String {
    return "TableView - Section"
  }

  lazy var sectionTitles: [String] = fruitsDict.keys.sorted() // 딕셔너리 정렬안되있으므로 정렬 하고 저장.
  let fruitsDict = [
    "A": ["Apple", "Avocado"],
    "B": ["Banana", "Blackberry"],
    "C": ["Cherry", "Coconut"],
    "D": ["Durian"],
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let tableView = UITableView(frame: view.frame)
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")
    view.addSubview(tableView)
  }
}


// MARK: - UITableViewDataSource

extension TableViewSection: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fruitsDict.count
    }
    
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return fruitsDict[sectionTitles[section]]!.count
  }
  
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
    let fruits = fruitsDict[sectionTitles[indexPath.section]]!
    cell.textLabel?.text = "\(fruits[indexPath.row])"
    return cell
  }
}
