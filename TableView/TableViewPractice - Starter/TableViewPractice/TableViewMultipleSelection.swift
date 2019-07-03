//
//  TableViewMultipleSelection.swift
//  TableViewPractice
//
//  Created by 이봉원 on 10/04/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

final class TableViewMultipleSelection: UIViewController {
  
  /***************************************************
   [ 실습 - TableViewRefresh 기능을 이어서 수행 ]
   
   1) 처음 화면에 띄워질 목록은 1부터 지정한 숫자까지의 숫자들을 출력
   2) 이후 갱신할 때마다 임의의 숫자들이 출력되도록 할 것
      랜덤 숫자의 범위는 출력할 숫자 개수의 +50 이며, 모든 숫자는 겹치지 않아야 함.
      (여기까지 TableViewRefresh 실습 내용과 동일)
   3) 특정 테이블뷰셀을 선택하고 갱신하면 해당 셀에 있던 숫자는 유지되고 나머지 숫자들만 랜덤하게 갱신되도록 처리
      (셀을 선택한 순서에 따라 그대로 다음 갱신 목록에 출력)
      e.g. 20, 10 두 개의 숫자를 선택하고 갱신하면, 다음 숫자 목록은 (20, 10, random, random...)
   4) 위 3번에서 숫자를 선택할 때 그 숫자가 7보다 작은 셀은 선택이 되지 않도록 처리.
   
   < 힌트 >
   키워드 - willSelectRow, selectedRow, multipleSelection
   ***************************************************/
    
    let tableView = UITableView()
    var randomNums: [Int] = Array(1...100)
    var selectedValue: [Int] = []
  
  override var description: String {
    return "Task 1 - MultipleSelection"
  }
  
    
    // MARK: - 라이프 사이클
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
  }
    
    // MARK: - 편의 메소드
    
    // tableview 만들기
    func setupTableView() {
        
        tableView.frame = view.frame
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")
        tableView.allowsMultipleSelection = true
        
        view.addSubview(tableView)
        
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "ing")
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshAction(sender:)), for: .valueChanged)
    
        
    }
    
    // 랜덤 숫자 생성하기
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
    
    // MARK: - 리프레시 컨트롤 액션함수
    @objc func refreshAction(sender: Any) {
        
        self.ranNumGenerator(count: 100)
        //randomNums.reverse()
        
        for index in 0..<selectedValue.count {
            let value = selectedValue[index]
            
            randomNums[index] = value
        }
        
//        for (index, value) in selectedValue.enumerated() {
//
//
//        }
        
        // 클릭한 아이들 변하지 않게 설정하기
//        for i in selectedRow {
//            randomNums[i] =
//        }
        
        
        
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
        
        selectedValue.removeAll()
    }
}

// MARK: - UITableViewDataSource 메소드

extension TableViewMultipleSelection: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return randomNums.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
    
    cell.textLabel?.text = "\(randomNums[indexPath.row])"
    return cell
  }
}

// MARK: - UITableViewDelegate 메소드

//  indexPathsForSelectedRows
extension TableViewMultipleSelection: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        //print("클릭한 인덱스는",indexPath.row)
        
        if randomNums[indexPath.row] < 7 {
            return nil
        }else {
            self.selectedValue.append(randomNums[indexPath.row])
            //print(selectedValue)
            return indexPath
        }
    }
}
