//
//  SecondViewController.swift
//  DataTransfer_Unwind
//
//  Created by 이봉원 on 02/04/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

final class SecondViewController: UIViewController {
  
  var data: String?
  
  @IBAction func valueChanged(_ sender: UISegmentedControl) {
    data = sender.titleForSegment(at: sender.selectedSegmentIndex)
  }
}
