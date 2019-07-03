//
//  FirstViewController.swift
//  DataTransfer_Unwind
//
//  Created by 이봉원 on 02/04/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

final class FirstViewController: UIViewController {
  
  @IBOutlet weak var displayLabel: UILabel!
  
  @IBAction func unwindToFirst(_ sender: UIStoryboardSegue) {
    guard let secondVC = sender.source as? SecondViewController else { return }
    displayLabel.text =  secondVC.data ?? "-1"
  }
}

