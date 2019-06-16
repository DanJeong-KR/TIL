//
//  Weather.swift
//  WeatherForecast
//
//  Created by chang sic jung on 11/06/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import Foundation

struct Weather: Codable {
    let date: String?
    let castTime: String? 
    let weatherImageCode: String?
    let temperature: String?
}

struct LocationInfo {
    let city: String
    let county: String
    let village: String
    
    init?(from json: [String : Any]) {
        guard let city = json["city"] as? String,
            let county = json["county"] as? String,
            let village = json["village"] as? String
            else { print("LocationInfo json Parsing Error"); return nil}
        self.city = city
        self.county = county
        self.village = village
    }
}

struct SkyInfo {
//    let code4Hour, code7Hour, code10Hour, code13Hour: String?
//    let code16Hour, code19Hour, code22Hour, code25Hour: String?
//    let code28Hour, code31Hour, code34Hour, code37Hour: String?
//    let code40Hour, code43Hour, code46Hour, code49Hour: String?
    var skyArr = [String?]()
    
    init?(from json: [String : Any]) {
        for i in 1...14 {
            let hour = String(3*i + 1)
            guard let data = json["code" + hour + "hour"] as? String
                else { print("SkyInfo json Parsing Error"); return nil }
            self.skyArr.append(data)
        }
    }
    
}

struct TemperatureInfo {
//    let temp4Hour, temp7Hour, temp10Hour, temp13Hour: String?
//    let temp16Hour, temp19Hour, temp22Hour, temp25Hour: String?
//    let temp28Hour, temp31Hour, temp34Hour, temp37Hour: String?
//    let temp40Hour, temp43Hour, temp46Hour, temp49Hour: String?
    var tempArr = [String?]()
    
    init?(from json: [String : Any]) {
        for i in 1...14 {
            let hour = String(3*i + 1)
            guard let data = json["temp" + hour + "hour"] as? String
                else { print("TemperatureInfo json Parsing Error"); return nil }
            self.tempArr.append(data)
        }
    }
}

// sky code 받았을 때 내 Asset 폴더의 이미지이름과 같게 만드는 작업.
func changeSkyImageCode(imageName: String?) -> String {
    
    guard let imageName = imageName else { logger("imageName 이 nil"); return "SKY_14"}
    // 17:00:33 : sky_14  // 14
    var weatherNumber = imageName.split(separator: "_").last!
    _ = weatherNumber.removeFirst()
    return "SKY_" + String(weatherNumber)
}

// 현재시간 내게 맞게 생성하기
func currentTimeGenerator() -> String {
    let now = Date()
    let calendar = Calendar.current
    let components = calendar.dateComponents([.hour, .minute], from: now)
    let minuteNum = components.minute ?? 0
    let hour = components.hour ?? 0
    
    // 6분일 때 06분이 아닌 6분으로 나오는 것 변환
    let minute = (0...9).contains(minuteNum) ? "0" + String(minuteNum) : String(minuteNum)
    
    if hour > 12 {
        return "오후 " + String(hour - 12) + ":" + String(minute)
    } else if hour == 0 { // 12 시 정각일 때  24시일 때 0시가 아닌 12시로 나오게 하기 위함
        return "오전 " + String(hour + 12) + ":" + String(minute)
    } else {
        return "오전 " + String(hour) + ":" + String(minute)
    }
}

// 요일까지 나오면서 indexPath 에 따라 시간 계산하고 String 으로 반환해주는 아이
func timeReleaseOptimizer(timeRelease: String, indexPathRow: Int) -> String {
    // 여기 "2019-06-11 17:00:00"  들어오면
    // // Sun 2019-06-16 18:00:00 이런 식으로 요일 추가해서 반환
    // indexPath 에 따라 날짜 , 요일 , 시간 알아야 해.
    let anHour:Int = 3600
    
    let dateFormatter = DateFormatter()
    //dateFormatter.locale = Locale(identifier: "ko-kr")
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    guard let releaseTime = dateFormatter.date(from: timeRelease) else {
        print(" 기상 발표시간을 DateFormatter 를 사용해서 Date 타입으로 변환 실패")
        return "에러"  }
    
    let weatherCastTime = Date(timeInterval: Double(anHour * 4 + anHour * (3 * indexPathRow)), since: releaseTime)
    
    dateFormatter.dateFormat = "EEE yyyy-MM-dd HH:mm:ss"
    let resultStr = dateFormatter.string(from: weatherCastTime)
    return resultStr
}

// 테이블 뷰 dateLabel 에 들어갈 부분
func makeDateLabelStr(inputStr: String) -> String {
    // Sun 2019-06-16 18:00:00 들어옴 -> 요일만 가져오자
    let splitDateArr = inputStr.split(separator: " ")
    
    // 2019-06-16 에서 년도 없앨 것
    let forSplitYear = splitDateArr[1].split(separator: "-") // 년도 없애버림
    
    let weekDay = splitDateArr[0]
    var day = forSplitYear[1] + "." + forSplitYear[2]
    
    // 06월 이 6월로(한자리로) 나오고 10 ~ 12월은 두자리로 나오게 만드는 로직
    let newDay = day.split(separator: ".").first!
    guard let dayInt = Int(String(newDay)) else { logger("error"); return "error"}
    
    if dayInt < 10 {
        _ = day.removeFirst()
    }
    print("day :",day, "weekDay :", weekDay)
    return day + " " + "(" + weekDay + ")"
    
}

// 테이블 뷰 castTime 만들기
func makeCastTimeLabelStr(inputStr: String) -> String {
    // // Sun 2019-06-16 18:00:00 에서 18:00 만 가져옴
    let splitDateArr = inputStr.split(separator: " ")
    let forSplitSecond = splitDateArr[2].split(separator: ":")
    
    let castTime = forSplitSecond[0] + ":" + forSplitSecond[1]
    
    return String(castTime)
}


func changeNumberFormatAndReturnString(numberStr: String?) -> String? {
    // 26.70 이면 26.7
    // 26.00 이면 26 으로 출력하기
    guard let numberStr = numberStr else {
        print("changeNumberFormatAndReturnString 에 매개변수가 nil 들어옵니다")
        return "에러"
    }
    
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    numberFormatter.minimum = 1
    
    guard let number = Double(numberStr) as? NSNumber else { print("numberFormatter 에서 NSNUmber 로 캐스팅 에러"); return nil }
    
    return numberFormatter.string(from: number)
}
