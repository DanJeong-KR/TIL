//
//  ViewController.swift
//  Calculator
//
//  Created by chang sic jung on 19/04/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    let calculatorView = CalculatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = calculatorView
        
    }


}

