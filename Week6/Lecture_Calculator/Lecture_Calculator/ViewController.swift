
/*
 
 숫자가 커지면 텍스트 크기가 작아지고
 일정 이상 커지면 입력이 제한되도록.
 
 스트링 포멧
 
 넘버 포멧터
 */

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
    
    // MARK: - View 라이프 사이클 ----------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTagAndAction()
        
    }
    // ----------------------------------------------------------
    
    
    
    
    // MARK: - 버튼들 태그와 액션메소드 연결
    func setupTagAndAction() {

        let numberButtons = [zeroButton,oneButton, twoButton, threeButton, fourButton, fiveButton, sixButton, sevenButton, eightButton, nineButton]
        
        let operationButtons = [plusButton, minusButton, timesButton, divideButton,clearButton,resultButton]
        
        
        // 숫자 버튼들 태그와 액션메소드 연결
        for i in 0..<numberButtons.count {
            let value = numberButtons[i]
            value?.tag = i
        }
        
        for button in numberButtons {
            button?.addTarget(self, action: #selector(numberAction(sender:)), for: .touchUpInside)
        }
        
        //사칙연산 버튼 태그와 액션메소드 연결
        plusButton.tag = 1
        minusButton.tag = 2
        timesButton.tag = 3
        divideButton.tag = 4
        
        clearButton.tag = 5
        resultButton.tag = 6
        
        for button in operationButtons {
            button?.addTarget(self, action: #selector(operationAction(sender:)), for: .touchUpInside)
        }
        
    }
    
    // MARK: - 사칙연산 버튼 액션메소드
    
    @objc func operationAction(sender: UIButton) {
        switch sender.tag {
        case 1:
//            print("+ 버튼")
//            print("원래 왼쪾에 있던 값",CalData.shared.leftOperand)
            // 왼쪾 연산자에 = 원래 왼쪽 연산자에 있던 값 + 현재 입력값
            let intLeft = Int(CalData.shared.leftOperand) ?? 0
            let intCurrent = Int(CalData.shared.currentValue) ?? 0
            
//            print("왼쪽",intLeft)
//            print("현재값",intCurrent)
            CalData.shared.resultValue = intLeft + intCurrent
            CalData.shared.leftOperand = String(intLeft + intCurrent)
            
//            displayLabel.text = CalData.shared.leftOperand
//
//            // 현재값 초기화 시켜주고 (디스플레이 에 빈 상태로 시작해야함 그래서 0 이 아님.)
//            CalData.shared.currentValue = ""
            resultButtonWork()
            
        case 2:
            print("-버튼")
            let intLeft = Int(CalData.shared.leftOperand) ?? 0
            let intCurrent = Int(CalData.shared.currentValue) ?? 0
            print("왼쪽값",CalData.shared.leftOperand,"/ 현재값",CalData.shared.currentValue)
            CalData.shared.resultValue = intLeft - intCurrent
            CalData.shared.leftOperand = String(intLeft - intCurrent)
            resultButtonWork()
        case 3:
            print("* 버튼")
        case 4:
            print("/ 버튼")
        case 5:
            print("clear 버튼")
            CalData.shared.currentValue = ""
            CalData.shared.leftOperand = "0"
            CalData.shared.resultValue = 0
            displayLabel.text = ""
        case 6:
            print("= 버튼")
            CalData.shared.leftOperand = CalData.shared.currentValue
            resultButtonWork()
        default:
            break
        }
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
    
    // 숫자버튼 누르면 현재 값에 값을 저장하고 라벨에 표시한다.
    func numberButton(sender: UIButton) {
        
        CalData.shared.currentValue.append("\(sender.tag)")
        displayLabel.text = CalData.shared.currentValue
        print("왼쪽값",CalData.shared.leftOperand,"/ 현재값",CalData.shared.currentValue)
    }
    
    func resultButtonWork() {
        
        //디스플레이에 표시하고
        displayLabel.text = "\(CalData.shared.resultValue ?? 0)"
        
        // 현재값 초기화 시켜주고 (디스플레이 에 빈 상태로 시작해야함 그래서 0 이 아님.)
        CalData.shared.currentValue = ""
        
    }
}


