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
    
    var isHoldingImage: Bool = false {
        didSet{
            if self.isHoldingImage {
                imageView.image = UIImage(named: "cat2")
            }else {
                imageView.image = UIImage(named: "cat1")
            }
        }
    }
    
    var tempX: CGFloat = 0
    var tempY: CGFloat = 0
    
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    imageView.layer.cornerRadius = imageView.frame.width / 2
    // 적용되지 않음 clipToBounds 설정 해주어야 한다.
    imageView.clipsToBounds = true
    //imageView.layer.masksToBounds = true
    
  }
    
    func setupForMoveImage(_ touchPoint: CGPoint) {
        tempX = touchPoint.x - imageView.frame.origin.x
        tempY = touchPoint.y - imageView.frame.origin.y
    }
    
    func moveImage(_ touchPoint: CGPoint) {
        if isHoldingImage {
            imageView.frame.origin = CGPoint(x: touchPoint.x - tempX , y: touchPoint.y - tempY)
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        print("touches began")

        guard let touch = touches.first else { return }
        let touchPoint = touch.location(in: touch.view)
        
        isHoldingImage = imageView.frame.contains(touchPoint)
        setupForMoveImage(touchPoint) // begin 단계에서 먼저 클릭한 좌표를 저장한다.
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        print("touches Moved")
        
        guard let touch = touches.first else { return }
        let touchPoint = touch.location(in: touch.view)

        moveImage(touchPoint)
    }
}


