//
//  ViewController.swift
//  DataTransfer_Segue
//
//  Created by 이봉원 on 03/04/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

final class FirstViewController: UIViewController {
  
  @IBOutlet private weak var countLabel: UILabel!
  
  var counter: [String: Int] = [
    "dog": 0, "cat": 0, "bird": 0
  ]
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    countLabel.text = "(\(counter["dog"]!), \(counter["cat"]!), \(counter["bird"]!))"
  }
  
  override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
    super.shouldPerformSegue(withIdentifier: identifier, sender: sender)
    guard let title = (sender as? UIButton)?.currentTitle?.lowercased(),
      let count = counter[title]
      else { return false }
    
    switch title {
    case "dog": return count <= 8
    case "cat": return count <= 10
    case "bird": return count <= 15
    default: return false
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    guard let dest = segue.destination as? SecondViewController,
      let title = (sender as? UIButton)?.currentTitle?.lowercased(),
      let count = counter[title]
      else { return }
    dest.imageName = title
    counter[title] = count + 1
  }
  
  @IBAction func unwindToFirstVC(_ unwindSegue: UIStoryboardSegue) {
    print("\n---------- [ unwindToFirstVC ] ----------\n")
    guard let source = unwindSegue.source as? SecondViewController else { return }
    for key in counter.keys {
      counter[key] = counter[key]! + source.tapCount
    }
  }
}

