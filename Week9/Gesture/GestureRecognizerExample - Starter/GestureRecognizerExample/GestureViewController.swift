//
//  GestureViewController.swift
//  GestureRecognizerExample
//
//  Created by giftbot on 02/05/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

// 스와이프 왼쪽으로 -> cat 1
// 스와이프 오른쪽으로 -> cat 2

import UIKit

class GestureViewController: UIViewController {
  
  @IBOutlet private weak var imageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    imageView.layer.cornerRadius  = imageView.frame.width / 2
    imageView.layer.masksToBounds = true
    
  }
    
    var isQuadruple = false
    @IBAction func handleTapGesture(_ sender: UITapGestureRecognizer) {
        print("Double Tapped")
        //print(sender.location(in: sender.view))

        if !isQuadruple {
            imageView.transform = imageView.transform.scaledBy(x: 2, y: 2)
        }else {
            imageView.transform = CGAffineTransform.identity // 단위 행렬로 만들어 주는 것.
        }
        
        isQuadruple.toggle()
    }
    
    @IBAction func handleRotationGesture(_ sender: UIRotationGestureRecognizer) {
        let rotation = sender.rotation
        
        imageView.transform = imageView.transform.rotated(by: rotation)
        sender.rotation = 0
        
        //imageView.transform = CGAffineTransform.identity.rotated(by: rotation)
    }
    
    @IBAction func handleSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        
        switch sender.direction {
        case .right:
            imageView.image = UIImage(named: "cat2")
            print("right")
        case .left:
            imageView.image = UIImage(named: "cat1")
            print("left")
        default:
            break
        }
    }
    
}
