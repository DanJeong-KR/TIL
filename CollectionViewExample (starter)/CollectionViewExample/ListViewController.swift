//
//  ViewController.swift
//  CollectionViewExample
//
//  Created by giftbot on 27/05/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

final class ListViewController: UIViewController {

  @IBOutlet private weak var tableView: UITableView!
  let viewControllers = [
    "BasicStoryboardViewController",
    "CustomCellViewController",
    "SectionViewController",
    "FlexibleViewController",
  ]
}

// MARK: - UITableViewDataSource

extension ListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewControllers.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
    cell.textLabel?.text = viewControllers[indexPath.row]
    cell.accessoryType = .disclosureIndicator
    return cell
  }
}

// MARK: - UITableViewDelegate

extension ListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vcId = viewControllers[indexPath.row]
    let vc = storyboard!.instantiateViewController(withIdentifier: vcId)
    navigationController?.pushViewController(vc, animated: true)
  }

}

