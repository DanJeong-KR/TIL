//
//  SecondViewController.swift
//  Problem_Delegate2
//
//  Created by chang sic jung on 08/04/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

// 내가 만드는 델리게이트 패턴
//위임 해주는 객체 : SecondViewController
//위임 받는 객체 : FirstViewController
protocol SecondToFirstDelegate : class {
    
    // 위임 받는 First 가 구현해야할 func
    func sendText_SecondToFirst() -> String
}

class SecondViewController: UIViewController {
    
    var test = ""
    // 위임 해주는 Second 에서 delegate 프로퍼티 옵셔널로 만들고.
    weak var delegate : SecondToFirstDelegate?
    
    var text: String?

    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 커스텀 포인트 . 위임해준 first 에서 커스텀한 sendText() 를 받아 내 할일만 하는 second
        let text = delegate?.sendText_SecondToFirst() ?? "not"
        
        displayLabel.text = text
    }
}

extension SecondViewController: FirstToSecondDelegate {
    func sendText_FirstToSecond(_ text: String) {
        self.text = text
    }
}


