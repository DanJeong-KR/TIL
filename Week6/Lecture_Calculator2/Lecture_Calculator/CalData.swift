import Foundation


// 데이터 모델.
// 데이터를 연산하고 저장하는 부분.
class CalData {
    
    var calculateValue: Double = 0.0
    
    var opButtonInfo = ("",false) // 연산자 정보와, 연산자 버튼 클릭된정보
    
    var isNumberButtonTap = false
    
    var leftOperand: Double? = nil
    var rightOperand: Double = 0.0
    
    // 컨트롤러에서 연산자 버튼 누르면 연산을 하는 부분
    func operate() {
        
        switch opButtonInfo.0 {
        case "+":
            plusOperate()
        case "−":
            minusOperate()
        case "×":
            timesOperate()
        case "÷":
            divisionOperate()
        case "=":
            if opButtonInfo.0 == "+" {
                calculateValue = leftOperand! + rightOperand
            }else if opButtonInfo.0 == "−" {
                calculateValue = leftOperand! - rightOperand
            }else if opButtonInfo.0 == "×" {
                calculateValue = leftOperand! * rightOperand
            }else if opButtonInfo.0 == "÷" {
                calculateValue = leftOperand! / rightOperand
            }else {
                print("띠옹")
            }
            
        default:
            break
        }
    }
    
    func clearData() {
        calculateValue = 0.0
        opButtonInfo = ("",false)
        isNumberButtonTap = false
        
        leftOperand = nil
        rightOperand = 0.0
    }
    
    
    func plusOperate() {
        print("+연산 하는 부분.")
        if opButtonInfo.1 == false {
            calculateValue = leftOperand! + rightOperand
        }
        isNumberButtonTap = false
    }
    
    func minusOperate() {
        print("-연산해서 계산값에 올림")
        
        if !opButtonInfo.1 {
            calculateValue = leftOperand! - rightOperand
        }
        isNumberButtonTap = false
    }
    
    func timesOperate() {
        print("*연산해서 계산값에 올림")
        if !opButtonInfo.1 {
            calculateValue = leftOperand! * rightOperand
        }
        isNumberButtonTap = false
    }
    
    func divisionOperate() {
        print("/연산해서 계산값에 올림")
        if !opButtonInfo.1 {
            calculateValue = leftOperand! / rightOperand
        }
        isNumberButtonTap = false
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    static let shared = CalData()
    private init () {
        
        leftOperand = "0"
        rightOperand = "0"
        currentValue = ""
        resultValue = 0
        buttonInfo = ""
        buttonCount = 0
    }
    

    var leftOperand: String?
    var rightOperand: String? {
        willSet {
            leftOperand = self.rightOperand
        }
    }
    
    var currentValue: String?
    var resultValue: Int?
    var buttonCount: Int
        
    var buttonInfo: String
    */
}
