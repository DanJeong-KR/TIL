
let data1 = Array(1...100)
let data2 = [0, 3, 9, 15, 27, 33, 41, 49, 90, 98]

var arrayData2:[[Int]?] = []

var tempArray:[Int] = []
for i in data2 {
    let temp:Int = i / 10
    tempArray.append(temp)
}
print(tempArray)

for i in 0...10 {
    if tempArray.contains(i) {
        arrayData2.append([])
    }else {
        arrayData2.append(nil)
    }
}
print(arrayData2)


for i in data2 {
    let temp: Int = i / 10
    arrayData2[temp]!.append(i)
}












/***************************************************
 1. 시험 시간
 10시 ~ 13시 - Playground 에 작성 후 제출
 13시 ~ 14시 - 점심시간
 14시 ~ 18시 - 작성한 Xcode 프로젝트를 압축하여 제출
 
 2. 제출 방법
 디렉토리 이름을 자신의 이름으로 만들고 그 안에 파일을 넣어 압축하여 슬랙으로 전달
 
 3. 전달사항
 화이팅!
 ***************************************************/




//: [Next](@next)
