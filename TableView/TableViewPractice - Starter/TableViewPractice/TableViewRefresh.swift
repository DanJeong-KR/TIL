//
//  TableViewRefresh.swift
//  TableViewPractice
//
//  Created by 이봉원 on 10/04/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

final class TableViewRefresh: UIViewController {
  
  /***************************************************
   UIRefreshControl을 이용해 목록을 갱신할 때마다 임의의 숫자들이 출력되도록 할 것
   랜덤 숫자의 범위는 출력할 숫자 개수의 +50 이며, 모든 숫자는 겹치지 않아야 함.
   e.g.
   20개 출력 시, 랜덤 숫자의 범위는 0 ~ 70
   40개 출력 시, 랜덤 숫자의 범위는 0 ~ 90
   
   < 참고 >
   (0...10).randomElement()  -  0부터 10사이에 임의의 숫자를 뽑아줌
   ***************************************************/
    
    
  
  override var description: String {
    return "Practice 3 - Refresh"
  }
  let tableView = UITableView()
    
    var randomNums: [Int] = []
  
    
    // -----------------------        life cycle          ------------------
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    
    ranNumGenerator(count: 20) // 20개 출력
    
    print(randomNums)
  }
    
    // 랜덤숫자 생성하는 함수.
    func ranNumGenerator(count outputNum : Int) {
        randomNums.removeAll() // 배열 초기화
        
        var count = 0
        while count < outputNum {
            let randomNum = (0...outputNum+50).randomElement()!
            if !randomNums.contains(randomNum){
                randomNums.append(randomNum)
                count += 1
            }else {
                continue
            }
        }
    }
    
    func recur_randomGen(count outputNum: Int) {
        
        let randomNum = (0...outputNum+50).randomElement()!
        
        if randomNums.count == 50 { // base case
            
        }else if !randomNums.contains(randomNum) {
            randomNums.append(randomNum)
        }else {
            
        }
    }
    
    
    //----------------------
  
  func setupTableView() {
    tableView.frame = view.frame
    view.addSubview(tableView)
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")
    tableView.dataSource = self
    
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
    refreshControl.tintColor = .blue
    refreshControl.attributedTitle = NSAttributedString(string: "Reverse!")
    tableView.refreshControl = refreshControl
  }
    
    @objc func reloadData() {
        
        self.ranNumGenerator(count: 20)
        
        tableView.refreshControl?.endRefreshing()
        tableView.reloadData()
    }
    
    
}

// MARK: - UITableViewDataSource

extension TableViewRefresh: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return randomNums.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
    
    cell.textLabel?.text = "\(randomNums[indexPath.row])"
    return cell
  }
}
