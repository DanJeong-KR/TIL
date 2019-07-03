//
//  ListViewController.swift
//  TableViewPractice
//
//  Created by 이봉원 on 10/04/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

final class ListViewController: UIViewController {
  let tableView = UITableView()
  var viewControllers: [UIViewController] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.frame = view.frame
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "List")
    view.addSubview(tableView)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewControllers = [
      TableViewNumbers(),
      TableViewSection(),
      TableViewRefresh(),
      TableViewMultipleSelection(),
      TableViewAccessoryType(),
    ]
  }
}


// MARK: - UITableViewDataSource

extension ListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewControllers.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "List", for: indexPath)
    cell.textLabel?.text = "\(viewControllers[indexPath.row])"
    return cell
  }
}

// MARK: - UITableViewDelegate

extension ListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = viewControllers[indexPath.row]
    navigationController?.pushViewController(vc, animated: true)
  }
}

