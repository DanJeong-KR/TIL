//
//  TableViewEditing.swift
//  BasicTableView
//
//  Created by 이봉원 on 09/04/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

final class TableViewEditing: UIViewController {
  
  /***************************************************
   테이블뷰 목록 수정하기 (insert, delete 등)
   ***************************************************/
  
  override var description: String {
    return "TableView - Editing"
  }
  
  let tableView = UITableView()
  var data = Array(1...50)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      title: "Edit", style: .plain, target: self, action: #selector(switchToEditing)
    )
  }
  
  func setupTableView() {
    tableView.frame = view.frame
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")
    view.addSubview(tableView)
    
    let refreshControl = UIRefreshControl()
    refreshControl.attributedTitle = NSAttributedString(string: "Refreshing...")
    refreshControl.tintColor = .blue
    refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
    tableView.refreshControl = refreshControl
  }
  
  @objc func reloadData() {
    tableView.refreshControl?.endRefreshing()
    tableView.reloadData()
  }
  
  @objc func switchToEditing() {
    /* 애니메이션 없는거 */ //tableView.isEditing.toggle()
    tableView.setEditing(!tableView.isEditing, animated: true)
  }
}

// MARK: - UITableViewDataSource

extension TableViewEditing: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
    cell.textLabel?.text = "\(data[indexPath.row])"
    return cell
  }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .none:
            print("none")
        case .insert:
            print("insert")
            data.insert(1, at: data.firstIndex(of: indexPath.row + 1)!)
            tableView.insertRows(at: [indexPath], with: .automatic)
        case .delete:
            print("delete")
            // 데이터 먼저 지우고 나서
            data.remove(at: data.firstIndex(of: data[indexPath.row])!)
            // 테이블 뷰에 지우라고 같이 맞춰주어야 한다는 거.
            tableView.deleteRows(at: [indexPath], with: .automatic) // tableView 에서 데이터가 지워질때 데이터가 맞아야 한다. 그래서 이게 나중에.
            
        @unknown default: // 혹시나 나중에 추가될 default 가 있으니 알고 써라.
            print("Unknown case")
        }
    }
}

// MARK: - UITableViewDelegate

extension TableViewEditing: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        let row = indexPath.row
        if row.isMultiple(of: 3) {
            return .none
        }else if row % 3 == 1 {
            return .insert
        } else{
            return .delete
        }
    }
    
    // iOS 11 부터 가능
    
    /*
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        print("trailing Swipe Action")
        let addAction = UIContextualAction(style: .destructive, title: "add") {
            (action,sourceView, actionPerformd) in
            print("add Action")
            actionPerformd(true)
        }
        addAction.backgroundColor = .green
        //return UISwipeActionsConfiguration(actions: [addAction])
        let configuration = UISwipeActionsConfiguration(actions: [addAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        print("leading Swife Action")
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") {
            (action,sourceView, actionPerformd) in
            print("Delete Action")
            
            // 데이터 지우는 로직
            self.data.remove(at: self.data.firstIndex(of: self.data[indexPath.row])!)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            actionPerformd(true)
        }
        deleteAction.backgroundColor = .green
        //return UISwipeActionsConfiguration(actions: [addAction])
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
 */
    
    // iOS 8 ~ iOS 10
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        print("editActionsForRowAt")
        
        let addAction = UITableViewRowAction(style: .default, title: "Add"){
            (action, indexPath) in
            print("Add")
        }
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit"){
            (action, indexPath) in
            print("Edit")
        }
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete"){
            (action, indexPath) in
            print("Delete")
        }
        
        return [addAction,editAction,deleteAction]
    }
    
    
}

