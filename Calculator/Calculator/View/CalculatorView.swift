//
//  CalculatorView.swift
//  Calculator
//
//  Created by chang sic jung on 19/04/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class CalculatorView: UIView {
    
    let testButton = UIButton()
    let testOpButton = OperationButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewSetup()
        buttonSetup()
        
        testOpButton.frame = CGRect(x: 50, y: 200, width: 50, height: 50)
        addSubview(testOpButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK : - View 설정하기
    func viewSetup() {
        backgroundColor = .white
    }
    
    // MARk : - Button 설정하기.
    func buttonSetup() {
        self.addSubview(testButton)
        testButton.frame = CGRect(x: 30, y: 30, width: 50, height: 50)
        testButton.backgroundColor = .yellow
        
    }
}
