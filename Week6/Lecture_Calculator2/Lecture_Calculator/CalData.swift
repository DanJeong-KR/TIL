import Foundation


// 데이터 모델.
// 데이터를 연산하고 저장하는 부분.
class CalData {
    
    var operandArray: [Double?] = [nil,nil]
    
    var calculateValue: Double = 0.0
    
    var result: String {
        get { return String(calculateValue) }
    }
    
    var leftOperand: Double? = nil
    var rightOperand: Double = 0.0
    
    var opInfo: (String,Bool) = ("",false) // op , op버튼 눌러졌는지  정보
    var isButtonFirst = true
    
    func operate() {
        switch opInfo.0 {
        case "+":
            calculateValue = leftOperand! + rightOperand
        case "−":
            calculateValue = leftOperand! - rightOperand
        case "×":
            calculateValue = leftOperand! * rightOperand
        case "÷":
            calculateValue = leftOperand! / rightOperand
            
        default:
            break
        }
        
        // 계산이 수행됬으면 다음 계산을 위해 초기화.
        opInfo = ("",false)
    }
    
    
    func clear() {
        calculateValue = 0.0
        leftOperand = nil
        rightOperand = 0.0
        opInfo = ("",false)
        isButtonFirst = true
    }
}
