//
//  ViewController.swift
//  TouchProblem
//
//  Created by chang sic jung on 07/05/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class TouchViewController: UIViewController {
    
    var activeRect: CGRect?
    
    var isMakeNewSpace: Bool = true
    
    // 라벨
    @IBOutlet weak var touchCountLabel: UILabel!
    var touchCount:Int = 0 {
        didSet {
            touchCountLabel.text = String(self.touchCount)
        }
    }
    
    // 좌표
    @IBOutlet weak var coordinateLabel: UILabel!
    var coordinate: CGPoint = CGPoint(x: 0, y: 0) {
        didSet {
            coordinateLabel.text = "( \(self.coordinate.x) , \(self.coordinate.y) )"
        }
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        guard let touch = touches.first else { return }
        let touchPoint = touch.location(in: view)
        
        coordinate = touchPoint
        
        if isMakeNewSpace {
            
            activeRect = CGRect(x: touchPoint.x - 20, y: touchPoint.y - 20, width: 40, height: 40)
            isMakeNewSpace = false
        }
        
        if activeRect!.contains(touchPoint) {
            touchCount += 1
        }else {
            isMakeNewSpace = true
            touchCount = 1
        }
    }

}

