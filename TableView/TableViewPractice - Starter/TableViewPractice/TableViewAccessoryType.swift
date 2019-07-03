//
//  TableViewAccessoryType.swift
//  TableViewPractice
//
//  Created by 이봉원 on 10/04/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

final class TableViewAccessoryType: UIViewController {
  
  /***************************************************
   - 미리 정해진 동물의 이미지와 텍스트를 테이블뷰에 표현
   - 각 셀의 크기는 80
   - 셀을 선택하면 체크박스가 나타나고 다시 선택하면 체크표시가 해제되도록 구현
   
   도전 과제)
   테이블뷰의 각 셀을 위아래로 스크롤 했다가 다시 나타낼 때, 체크 표시가 기존에 했던 곳에 정확히 다시 나타나도록 구현
   ***************************************************/
  
  override var description: String {
    return "Task 2 - AccessoryType"
  }
  //--------------------- 데이터 모델 ------------------------------
    
  let animals = [
    "bear", "buffalo", "camel", "dog", "elephant",
    "koala", "llama", "panda", "lion", "horse",
    "guinea_pig", "koala", "whale_shark", "whale", "duck",
    "seagull", "black_swan", "peacock", "giraffe"
  ]
    var selectedInfo:[Bool] = []
    
    //--------------------- 데이터 모델 -----------------------------
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let tableView = UITableView(frame: view.frame)
    
    tableView.dataSource = self
    tableView.delegate = self
    
    view.addSubview(tableView)
    
    for _ in 1...animals.count {
        selectedInfo.append(false)
    }
    
    tableView.rowHeight = 80
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")
    tableView.allowsMultipleSelection = true
  }
}


extension TableViewAccessoryType: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return animals.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
    
    cell.textLabel?.text = animals[indexPath.row]
    cell.imageView?.image = UIImage(named: animals[indexPath.row])
    
    
    // 셀을 재사용 할 때 체크된 상태에 따라 다시 설정해주기.
    if selectedInfo[indexPath.row] {
        cell.accessoryType = .checkmark
    }else {
        cell.accessoryType = .none
    }
//
    return cell
  }
}


extension TableViewAccessoryType: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        
        selectedInfo[indexPath.row] = true
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
        
        selectedInfo[indexPath.row] = false
    }
    
}


