//
//  ViewController.swift
//  CalculatorExample
//
//  Created by giftbot on 17/04/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

// 컨트롤러 : 뷰에 데이터를 뿌려는 역할
final class ViewController: UIViewController {
  
  @IBOutlet private weak var displayLabel: UILabel!
    
    private let calculator = Calculator()
  
  // displayValue 라는 아이로 displayLabel 을 관리 하자.
    private var displayValue: String {
        get { return displayLabel.text ?? "" }
        set { displayLabel.text = newValue}
    }
    
    
  
  @IBAction private func didTapButton(_ sender: UIButton) {
    guard let input = sender.currentTitle else { return }
    
    let command: Command
    switch input {
    case "AC":
        command = .clear
    case "=":
        command = .equal
    case "+","-","×","÷":
        command = .operation(input)
    default:
        command = .addDigit(input)
    }
    print(command)
    
    let removedCommaString = displayValue.replacingOccurrences(of: ",", with: "")
    
    // 계산은 콤마 없이 하고!
    let result = calculator.performCommand(command, with: removedCommaString)
    
    // displayValue 에 넣을 때는 limitFractionDigits 을 거치기 때문에 , 생긴다.
    displayValue = limitFractionDigits(to: result)
    
    print("display : \(displayValue) , command: \(command)")
    }
    
    
    // "사칙연산 기능 개선" 부분 commit
    func limitFractionDigits(to numString: String) -> String {
        guard let number = Double(numString) else { return "0" }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 3
        return formatter.string(from: number as NSNumber) ?? "0"
    }

}
