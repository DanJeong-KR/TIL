
/*
 
 숫자가 커지면 텍스트 크기가 작아지고
 일정 이상 커지면 입력이 제한되도록.
 
 스트링 포멧
 
 넘버 포멧터
 */

// 컨트롤러
// 데이터를 받아서 뷰에 표현하거나 특정 시점 처리를 해주는 부분.


import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!

    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var eightButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    @IBOutlet weak var zeroButton: UIButton!
    
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var timesButton: UIButton!
    @IBOutlet weak var divideButton: UIButton!
    
    @IBOutlet weak var resultButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    let calData = CalData()
    
    // MARK: - View 라이프 사이클 ----------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTagAndAction()
    }
    // ----------------------------------------------------------
    
    
    
    
    // MARK: - 버튼들 태그와 액션메소드 연결
    func setupTagAndAction() {

        let numberButtons = [zeroButton,oneButton, twoButton, threeButton, fourButton, fiveButton, sixButton, sevenButton, eightButton, nineButton]
        
        let operationButtons = [plusButton, minusButton, timesButton, divideButton]
        
        
        // 숫자 버튼들 태그와 액션메소드 연결
        for i in 0..<numberButtons.count {
            let value = numberButtons[i]
            value?.tag = i
        }
        
        for button in numberButtons {
            button?.addTarget(self, action: #selector(numberAction(sender:)), for: .touchUpInside)
        }
        
        //사칙연산 버튼 태그와 액션메소드 연결
        for button in operationButtons {
            button?.addTarget(self, action: #selector(operationAction(sender:)), for: .touchUpInside)
        }
        
        clearButton.addTarget(self, action: #selector(clearAction(sender:)), for: .touchUpInside)
        
        resultButton.addTarget(self, action: #selector(resultAction(sender:)), for: .touchUpInside)
    }
    
    // MARK: - 사칙연산 버튼 액션메소드
    @objc func operationAction(sender: UIButton) {
        
        calData.isButtonFirst = true
        
        switch sender.titleLabel?.text! {
        case "+":
            if calData.leftOperand == nil {
                calData.leftOperand = Double(displayLabel.text!)!
            } else { calData.rightOperand = Double(displayLabel.text!)! }
            
        case "−":
            if calData.leftOperand == nil {
                calData.leftOperand = Double(displayLabel.text!)!
            } else { calData.rightOperand = Double(displayLabel.text!)! }
        case "×":
            print("×")
            if calData.leftOperand == nil {
                calData.leftOperand = Double(displayLabel.text!)!
                calData.rightOperand = 1
            } else { calData.rightOperand = Double(displayLabel.text!)! }
        case "÷":
            print("÷")
            if calData.leftOperand == nil {
                calData.leftOperand = Double(displayLabel.text!)!
                calData.rightOperand = 1
            } else { calData.rightOperand = Double(displayLabel.text!)! }
        default:
            break
        }
        
        calData.opInfo.0 = (sender.titleLabel?.text)!
        
        if calData.opInfo.1 {
            calData.operate()
            calData.leftOperand = calData.calculateValue
            displayLabel.text = calData.result
        }
        
        calData.opInfo.1 = true
        
        print("left :",calData.leftOperand," / right :",calData.rightOperand," / calValue :",calData.calculateValue," / opInfo :",calData.opInfo)
        
    }
    

    // MARK: - 숫자 버튼 액션메소드
    @objc func numberAction(sender: UIButton) {
        
        switch sender.tag {
        case 0:
            print("0 버튼")
            numberButton(sender: sender)
        case 1:
            print("1 버튼")
            numberButton(sender: sender)
        case 2:
            numberButton(sender: sender)
        case 3:
            numberButton(sender: sender)
        case 4:
            numberButton(sender: sender)
        case 5:
            numberButton(sender: sender)
        case 6:
            numberButton(sender: sender)
        case 7:
            numberButton(sender: sender)
        case 8:
            numberButton(sender: sender)
        case 9:
            numberButton(sender: sender)
        default:
            break
        }
    }
    
    // 숫자버튼 누르면 처음 눌렀을 때와 아닐 떄 처리.
    func numberButton(sender: UIButton) {
        
        if calData.isButtonFirst {
            displayLabel.text = String(sender.tag)
            calData.isButtonFirst = false
        }
        else { displayLabel.text = self.displayLabel.text! + String(sender.tag) }
    }
    
    @objc func resultAction(sender: UIButton) {
        print("= 버튼")
        
        
        
        calData.isButtonFirst = true
        
        calData.rightOperand = Double(displayLabel.text!)!
        calData.operate()
        displayLabel.text = calData.result
    
        
        print("left :",calData.leftOperand," / right :",calData.rightOperand," / calValue :",calData.calculateValue," / opInfo :",calData.opInfo)
        
    }
    
    // MARK: - AC 버튼
    @objc func clearAction(sender: UIButton) {
        calData.clear()
        displayLabel.text = "0"
    }
}


