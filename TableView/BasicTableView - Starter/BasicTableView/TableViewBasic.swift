//
//  TableViewBasic.swift
//  BasicTableView
//
//  Created by 이봉원 on 09/04/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

final class TableViewBasic: UIViewController {
  
    
// 해당 객체를 출력하면 반환값인 String 으로 출력된다..
  override var description: String {
    return "TableView - Basic"
  }
  
    
  override func viewDidLoad() {
    super.viewDidLoad()
    let tableView = UITableView(frame: view.frame)
    tableView.dataSource = self
    view.addSubview(tableView)
    
    
    /*
     register - 재사용할 셀의 클래스를 미리 등록 가능 (스토리 보드에서 id 입력하는 것을 하는 코드)
     새로운 아이디면 -> 새로 등록
     같은 아이디면 -> 이전에 등록한 클래스를 업데이트 한다.
    */
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")
  }
}

extension TableViewBasic: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*
         1. 셀 생성
         */
        
//        let cell = UITableViewCell(style: .default, reuseIdentifier: "CellId")
//        cell.textLabel?.text = "\(indexPath.row + 1)" // indexPath 세션의 ~~ 번째 row
//        return cell
        
        /*
        2. 셀이 10만개 . 그 이상 ->  엄청 많을떄
         10만개의 셀이 메모리에 올라와서 사용됨.
         실제로 보여지는 건 18개 정도인데 ㅠㅠ.
         => 셀은 재사용이 필요함.
        */
//        let cell: UITableViewCell
//        if let resuableCell = tableView.dequeueReusableCell(withIdentifier: "CellId") {
//            // CellId 의 셀을 재사용 하겠다.
//            // 화면에 보이는 (15개정도) 셀들의 id 가 CellId 인 것. 하나의 셀 id 가 CellId 가 아닌 것.
//            cell = resuableCell
//        }else { // 없으면 새로 만들어라.
//            cell = UITableViewCell(style: .default, reuseIdentifier: "CellId")
//        }
//
//        cell.textLabel?.text = "\(indexPath.row + 1)"
//        return cell
        
        /*
         3. register 메소드를 사용해 미리 셀을 등록 가능 (코드를 간결하게 하려고)
         스토리 보드에서 만들떈 이 방법 -> viewdidload  에서 register 메소드로 등록해줘야함.
        */
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row + 1)"
        return cell
    
        
        //  코드로는 2,3 번 가능 // 스토리보드로는 3번만 가능
        
        
    }
}



