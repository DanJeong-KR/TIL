//
//  TouchViewController.swift
//  GestureRecognizerExample
//
//  Created by giftbot on 02/05/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

final class TouchViewController: UIViewController {

  @IBOutlet private weak var imageView: UIImageView!
    
    var isHoldingImage: Bool?
    
    var tempX: CGFloat = 0
    var tempY:CGFloat = 0
    
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    imageView.layer.cornerRadius = imageView.frame.width / 2
    // 적용되지 않음
    imageView.backgroundColor = .red
    
    imageView.clipsToBounds = true
    print(imageView.layer.masksToBounds)
    
  }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        print("touches began")

        guard let touch = touches.first else { return }
        let touchPoint = touch.location(in: touch.view)
        isHoldingImage = imageView.frame.contains(touchPoint)
        
        tempX = touchPoint.x - imageView.frame.origin.x
        tempY = touchPoint.y - imageView.frame.origin.y
        
        if isHoldingImage ?? false {
            imageView.image = UIImage(named: "cat2")
            
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        print("touches Moved")
        
        guard let touch = touches.first else { return }
        let touchPoint = touch.location(in: touch.view)
        print(touchPoint)

        if isHoldingImage ?? false {
            imageView.image = UIImage(named: "cat2")
           
            imageView.frame.origin = CGPoint(x: touchPoint.x - tempX , y: touchPoint.y - tempY)
            
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
//        guard let touch = touches.first else { return }
//        let touchPoint = touch.location(in: touch.view)
//        print(touchPoint)
        print("touches ended")
        imageView.image = UIImage(named: "cat1")
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        // 터치중에 전화가 온다던지 상황에서 호출.
        print("touches canceled")
        
    }
}


