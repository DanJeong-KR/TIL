
import Foundation


func selectionSort(input: inout [Int]) {
    
    guard input.count != 0 else { print("빈 배열입니다.");return}
    
    //    for i in 0..<input.count - 1 {
    //
    //        var min = 200
    //        var index = 0
    //        for j in i..<input.count {
    //            if input[j] < min {
    //                min = input[j]
    //                index = j
    //            }
    //        }
    //        let temp = input[i]
    //        input[i] = input[index]
    //        input[index] = temp
    //
    //    }
    for i in 0..<input.count - 1 {
        
        var minIndex = i
        for iterMinIndex in i..<input.count {
            if input[iterMinIndex] < input[minIndex] {
                minIndex = iterMinIndex
            }
        }
        let temp = input[i]
        input[i] = input[minIndex]
        input[minIndex] = temp
        
    }
}
