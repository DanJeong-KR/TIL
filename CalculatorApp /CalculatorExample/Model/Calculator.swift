
import Foundation



// 앱이 데이터가 관리되는 부분.
// MVC 중 Model 부분
// "perfomCommand 메소드에 private 제거" 부분
final class Calculator {
    
    enum Operator: String {
        case addition = "+"
        case subtraction = "-"
        case multiplication = "×"
        case division = "÷"
        
        var calculate: (Double, Double) -> Double {
            switch self {
            case .addition: return (+)//{ $0 + $1 }
            case .subtraction: return (-)//{ $0 - $1 }
            case .multiplication: return (*)//{ $0 * $1 }
            case .division : return (/)//{ $0 / $1 }
            }
        }
    }
    
    
    private var accumulator = 0.0
    private var bufferOperator: Operator?
    // 처음 숫자 눌렀을 때 0 없앨 건지에 대한.
    private var shouldResetText = true
    
    
    // 기존의 값과 새로 들어올 값을 계산해준다.
    private func calculate(for newValue: String) -> Double {
        
        let operand = Double(newValue)!
        
//        switch bufferOperator {
//        case "+": return accumulator + operand
//        case "-": return accumulator - operand
//        case "×": return accumulator * operand
//        case "÷": return accumulator / operand
//        default: return operand
//        }
        
        return bufferOperator?.calculate(accumulator, operand) ?? operand
          //  (bufferOperator != nil) ? bufferOperator!.calculate(accumulator, operand) : operand
        
    }
    
    private func addDigit(value newValue: String, to oldValue: String) -> String {
        // 삼항연산자 2번 써서
        let displayString = shouldResetText ? newValue : oldValue.count > 13 ? oldValue : oldValue + newValue
        
        shouldResetText = false
        return displayString
    }
    
    private func changeState(accumulator: Double, op: Operator? = nil) {
        self.accumulator = accumulator
        bufferOperator = op
    }
    
    func performCommand(_ command: Command, with displayText: String) -> String {
        
        var result: Double?
        
        switch command {
            // 숫자가 들어오게 되면 숫자가 뒤에 더해지는 작업
        // commit 에서 "addDigit 에 대한 기능 추가" 부분
        case .addDigit(let input):
            return addDigit(value: input, to: displayText)
            
        case .operation(let op):
            
            let hasChangedOp = bufferOperator != nil && shouldResetText
            let accu = hasChangedOp
                ? accumulator
                : calculate(for: displayText)
            result = hasChangedOp ? Double(displayText) : accu
            // 이전에 연산자를 눌렀냐 아니냐를 체크 // 이전에 숫자를 눌렀냐를 체크
            
            changeState(accumulator: calculate(for: displayText),op: Operator(rawValue: op))
//            accumulator = calculate(for: displayText)
//            bufferOperator = op
            //result = accumulator
        case .equal:
            // 결과를 그냥 넣어주면 됨.
            result = calculate(for: displayText)
            
            fallthrough // 아래 코드가 실행되기 때문에
//            accumulator = 0
//            bufferOperator = nil
        case .clear: changeState(accumulator: 0)
//            accumulator = 0
//            bufferOperator = nil
        default:
            break
        }
        
        // .addDigit 에서 return 이 수행됬으면 요게 실행이 안되
        shouldResetText = true
        return String(result ?? 0)
    }
    
    
}
