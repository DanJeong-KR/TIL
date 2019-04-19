//
//  OperationButton.swift
//  Calculator
//
//  Created by chang sic jung on 19/04/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class OperationButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        ButtonSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func ButtonSetup() {
        backgroundColor = .red
    }
    
    // 레이아웃을 바꾸려면 왜 이 메소드를 써야하는 걸까?
    // 초기화 단계에서 레이아웃을 바꾸면 안되는 이유가 뭘까?
    
    override func layoutSubviews() {
        layer.cornerRadius = self.frame.width / 2
    }
}
