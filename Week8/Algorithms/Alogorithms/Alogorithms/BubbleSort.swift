//
//  BubbleSort.swift
//  Alogorithms
//
//  Created by chang sic jung on 03/05/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import Foundation



func bubbleSort(input: inout [Int]) {
    
    let inputCount = input.count
    guard inputCount >= 0 else { print("비교할 값이 적습니다."); return}
    
    for rotation in 1...inputCount - 1 {
        
        var preIdx = 0
        var postIdx = 1
        
        var isSorted = true
        while postIdx < inputCount - rotation + 1 {
            if input[preIdx] > input[postIdx] { // 앞에 수가 더 크다면
                let temp = input[postIdx]
                input[postIdx] = input[preIdx]
                input[preIdx] = temp
                
                isSorted = false
            }
            preIdx += 1
            postIdx += 1
            print(input)
            
        }
        
        if isSorted { break }
        
    }
}
