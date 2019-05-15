//
//  ImageAnimationViewController.swift
//  UIViewAnimation
//
//  Created by giftbot on 2019. 5. 6..
//  Copyright © 2019년 giftbot. All rights reserved.
//

import UIKit

final class ImageAnimationViewController: UIViewController {
  
  @IBOutlet private weak var imageView: UIImageView!
  @IBOutlet private weak var durationLabel: UILabel!
  @IBOutlet private weak var repeatCountLabel: UILabel!
    
    let images = ["AppStore", "Calculator", "Calendar", "Camera", "Clock", "Contacts", "Files"].compactMap(UIImage.init(named:))
  
  override func viewDidLoad() {
    super.viewDidLoad()
    imageView.animationImages = images
    imageView.startAnimating()
  }
  
  @IBAction private func startAnimation(_ sender: Any) {
    imageView.startAnimating()
  }
  
  @IBAction private func stopAnimation(_ sender: Any) {
    guard imageView.isAnimating else { return }
    imageView.stopAnimating()
  }
  
  @IBAction private func durationStepper(_ sender: UIStepper) {
    durationLabel.text = "\(Int(sender.value))"
    
    // 1 Cycle
    // default : 1초에 30번 돌리기. -> 2로 하면 2초에 30장
    imageView.animationDuration = sender.value
  }
  
  @IBAction private func repeatCountStepper(_ sender: UIStepper) {
    let repeatCount = Int(sender.value)
    repeatCountLabel.text = "\(repeatCount)"
    
    imageView.animationRepeatCount = repeatCount
  }
}
