//
//  SampleData.swift
//  WeatherForecast
//
//  Created by giftbot on 13/06/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import Foundation

struct SampleData {
  static let currentForecast: Data = """
{
  "weather": {
    "hourly": [
      {
        "grid": {
          "longitude": "127.0977600000",
          "latitude": "37.1177600000",
          "county": "오산시",
          "village": "청호동",
          "city": "경기"
        },
        "wind": {
          "wdir": "288.00",
          "wspd": "3.50"
        },
        "precipitation": {
          "sinceOntime": "0.00",
          "type": "0"
        },
        "sky": {
          "code": "SKY_O01",
          "name": "맑음"
        },
        "temperature": {
          "tc": "19.20",
          "tmax": "24.00",
          "tmin": "13.00"
        },
        "humidity": "39.00",
        "lightning": "0",
        "timeRelease": "2017-05-25 18:00:00",
        "sunRiseTime": "2017-05-25 05:17:00",
        "sunSetTime": "2017-05-25 19:40:00"
      }
    ]
  },
  "common": {
    "alertYn": "Y",
    "stormYn": "N"
  },
  "result": {
    "code": 9200,
    "requestUrl": "/weather/current/hourly?version=2&lat=37.123&lon=127.123",
    "message": "성공"
  }
}
""".data(using: .utf8)!
  
  
  
  static let shortRangeForecast: Data = """
{
"weather": {
"forecast3days": [
{
"grid": {
"city": "경기",
"county": "오산시",
"longitude": "127.0977600000",
"latitude": "37.1177600000",
"village": "청호동"
},
"timeRelease": "2017-05-29 08:00:00",
"fcst3hour": {
"wind": {
"wdir4hour": "248.00",
"wspd4hour": "1.60",
"wdir7hour": "252.00",
"wspd7hour": "2.50",
"wdir10hour": "243.00",
"wspd10hour": "3.30",
"wdir13hour": "254.00",
"wspd13hour": "2.20",
"wdir16hour": "162.00",
"wspd16hour": "0.90",
"wdir19hour": "196.00",
"wspd19hour": "0.70",
"wdir22hour": "135.00",
"wspd22hour": "1.10",
"wdir25hour": "184.00",
"wspd25hour": "1.40",
"wdir28hour": "218.00",
"wspd28hour": "1.80",
"wdir31hour": "238.00",
"wspd31hour": "2.20",
"wdir34hour": "231.00",
"wspd34hour": "2.60",
"wdir37hour": "202.00",
"wspd37hour": "2.40",
"wdir40hour": "337.00",
"wspd40hour": "0.80",
"wdir43hour": "318.00",
"wspd43hour": "1.20",
"wdir46hour": "34.00",
"wspd46hour": "0.70",
"wdir49hour": "205.00",
"wspd49hour": "1.40",
"wdir52hour": "211.00",
"wspd52hour": "2.30",
"wdir55hour": "255.00",
"wspd55hour": "2.80",
"wdir58hour": "293.00",
"wspd58hour": "2.30",
"wdir61hour": "301.00",
"wspd61hour": "1.70",
"wdir64hour": "270.00",
"wspd64hour": "0.70",
"wdir67hour": "",
"wspd67hour": ""
},
"precipitation": {
"type4hour": "0",
"prob4hour": "0.00",
"type7hour": "0",
"prob7hour": "0.00",
"type10hour": "0",
"prob10hour": "0.00",
"type13hour": "0",
"prob13hour": "0.00",
"type16hour": "0",
"prob16hour": "0.00",
"type19hour": "0",
"prob19hour": "10.00",
"type22hour": "0",
"prob22hour": "20.00",
"type25hour": "0",
"prob25hour": "20.00",
"type28hour": "0",
"prob28hour": "20.00",
"type31hour": "0",
"prob31hour": "20.00",
"type34hour": "0",
"prob34hour": "20.00",
"type37hour": "0",
"prob37hour": "20.00",
"type40hour": "0",
"prob40hour": "20.00",
"type43hour": "0",
"prob43hour": "20.00",
"type46hour": "0",
"prob46hour": "20.00",
"type49hour": "0",
"prob49hour": "20.00",
"type52hour": "0",
"prob52hour": "30.00",
"type55hour": "0",
"prob55hour": "30.00",
"type58hour": "1",
"prob58hour": "60.00",
"type61hour": "0",
"prob61hour": "30.00",
"type64hour": "0",
"prob64hour": "30.00",
"type67hour": "",
"prob67hour": ""
},
"sky": {
"code4hour": "SKY_S01",
"name4hour": "맑음",
"code7hour": "SKY_S01",
"name7hour": "맑음",
"code10hour": "SKY_S01",
"name10hour": "맑음",
"code13hour": "SKY_S01",
"name13hour": "맑음",
"code16hour": "SKY_S01",
"name16hour": "맑음",
"code19hour": "SKY_S02",
"name19hour": "구름조금",
"code22hour": "SKY_S03",
"name22hour": "구름많음",
"code25hour": "SKY_S03",
"name25hour": "구름많음",
"code28hour": "SKY_S03",
"name28hour": "구름많음",
"code31hour": "SKY_S03",
"name31hour": "구름많음",
"code34hour": "SKY_S03",
"name34hour": "구름많음",
"code37hour": "SKY_S03",
"name37hour": "구름많음",
"code40hour": "SKY_S03",
"name40hour": "구름많음",
"code43hour": "SKY_S03",
"name43hour": "구름많음",
"code46hour": "SKY_S03",
"name46hour": "구름많음",
"code49hour": "SKY_S03",
"name49hour": "구름많음",
"code52hour": "SKY_S07",
"name52hour": "흐림",
"code55hour": "SKY_S07",
"name55hour": "흐림",
"code58hour": "SKY_S08",
"name58hour": "흐리고 비",
"code61hour": "SKY_S07",
"name61hour": "흐림",
"code64hour": "SKY_S07",
"name64hour": "흐림",
"code67hour": "",
"name67hour": ""
},
"temperature": {
"temp4hour": "27.00",
"temp7hour": "29.00",
"temp10hour": "27.00",
"temp13hour": "22.00",
"temp16hour": "19.00",
"temp19hour": "17.00",
"temp22hour": "17.00",
"temp25hour": "22.00",
"temp28hour": "26.00",
"temp31hour": "28.00",
"temp34hour": "26.00",
"temp37hour": "22.00",
"temp40hour": "19.00",
"temp43hour": "17.00",
"temp46hour": "16.00",
"temp49hour": "21.00",
"temp52hour": "25.00",
"temp55hour": "24.00",
"temp58hour": "22.00",
"temp61hour": "20.00",
"temp64hour": "18.00",
"temp67hour": ""
},
"humidity": {
"rh4hour": "35.00",
"rh7hour": "35.00",
"rh10hour": "35.00",
"rh13hour": "45.00",
"rh16hour": "60.00",
"rh19hour": "65.00",
"rh22hour": "60.00",
"rh25hour": "40.00",
"rh28hour": "35.00",
"rh31hour": "25.00",
"rh34hour": "25.00",
"rh37hour": "35.00",
"rh40hour": "45.00",
"rh43hour": "55.00",
"rh46hour": "65.00",
"rh49hour": "55.00",
"rh52hour": "50.00",
"rh55hour": "70.00",
"rh58hour": "80.00",
"rh61hour": "75.00",
"rh64hour": "75.00",
"rh67hour": ""
}
},
"fcstdaily": {
"temperature": {
"tmax1day": "30.00",
"tmax2day": "29.00",
"tmax3day": "25.00",
"tmin1day": "",
"tmin2day": "16.00",
"tmin3day": "16.00"
}
},
"fcst6hour": {
"rain6hour": "없음",
"rain12hour": "없음",
"rain18hour": "없음",
"rain24hour": "없음",
"rain30hour": "없음",
"rain36hour": "없음",
"rain42hour": "없음",
"rain48hour": "없음",
"rain54hour": "없음",
"snow6hour": "없음",
"snow12hour": "없음",
"snow18hour": "없음",
"snow24hour": "없음",
"snow30hour": "없음",
"snow36hour": "없음",
"snow42hour": "없음",
"snow48hour": "없음",
"snow54hour": "없음",
"rain60hour": "1~4mm",
"rain66hour": "없음",
"snow60hour": "없음",
"snow66hour": "없음"
}
}
]
},
"common": {
"alertYn": "Y",
"stormYn": "N"
},
"result": {
"code": 9200,
"requestUrl": "/weather/forecast/3days?version=2&lat=37.123&lon=127.123",
"message": "성공"
}
}
""".data(using: .utf8)!
  
}
