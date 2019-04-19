
import Foundation

class CalData {
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
        didSet {
            leftOperand = self.rightOperand
        }
    }
    
    var currentValue: String?
    var resultValue: Int?
    var buttonCount: Int
        
    var buttonInfo: String { // 1 부터 + - * /
        
        didSet {
            switch self.buttonInfo {
            case "plus":
                resultValue = Int(leftOperand!)! + Int(rightOperand!)!
            case "minus":
                resultValue = Int(leftOperand!)! - Int(rightOperand!)!
                print(resultValue!)
            default:
                print("ButtonInfo didSet 부분 default 빠짐")
                break
            }
        }
        
    }
}
