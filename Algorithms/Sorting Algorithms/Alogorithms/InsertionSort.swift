
import Foundation

//[5, 6, 1, 3, 10]
func insertionSort(input: inout [Int]) {
    
    guard input.count != 0 else { print("빈 배열입니다.");return}
    
    for idx in 1..<input.count {
        
        let currentValue = input[idx]
        
        var insertIdx = idx
        
        for compareIdx in (0..<idx).reversed() {
            guard currentValue < input[compareIdx] else { break }
            input[compareIdx + 1] = input[compareIdx]
            insertIdx = compareIdx
        }
        input[insertIdx] = currentValue
    }
    
    print(input)
    
}

