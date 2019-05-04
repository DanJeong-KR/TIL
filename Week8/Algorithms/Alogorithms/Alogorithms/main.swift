
import Foundation

var input = [5, 6, 1, 3, 10, 2, 7, 14, 9]
print("정렬되기 전 input :",input)

bubbleSort(input: &input)

print("정렬된 후 input :",input)


var inputTest = [5,2,4,6,1,3]

var inputCases = [
    [],
    [1],
    [1, 1, 2, 2, 3, 3, 3, 3, 1, 1, 2, 2],
    [14, 10, 9, 7, 6, 5, 3, 2, 1],
    [1, 2, 3, 5, 6, 7, 9, 10, 14],
    [5, 6, 1, 3, 10, 2, 7, 14, 9],
]


//selectionSort(input: &input)

//for cases in inputCases {
//    var tempArray = cases
//    selectionSort(input: &tempArray)
//    print("selection :",tempArray)
//    tempArray = cases
//    bubbleSort(input: &tempArray)
//    print("bubble :",tempArray)
//}

//insertionSort(input: &input)


