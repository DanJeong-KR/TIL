
import Foundation

class CalData {
    static let shared = CalData()
    private init () {
        leftOperand = "0"
        rightOperand = "0"
        currentValue = ""
        resultValue = 0
    }
    

    var leftOperand: String!
    var rightOperand: String!
    
    var currentValue: String!
    var resultValue: Int!
}
