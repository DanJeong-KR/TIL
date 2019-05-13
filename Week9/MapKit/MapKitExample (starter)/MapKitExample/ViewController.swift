//
//  ViewController.swift
//  MapKitExample
//
//  Created by giftbot on 2019. 5. 5..
//  Copyright © 2019년 giftbot. All rights reserved.
//

import UIKit
  
final class ViewController: UIViewController {
  let titles = ["MyLocationViewController", "GeocodeViewController", "BasicAnnotationViewController", "RendererOverlayViewController","CallOutActionViewController"]
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return titles.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel?.text = "\(titles[indexPath.row])"
    return cell
  }
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: titles[indexPath.row])
    vc.title = String(titles[indexPath.row].dropLast("ViewController".count))
    navigationController?.pushViewController(vc, animated: true)
  }
}



