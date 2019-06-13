//
//  ShortRangeForecast.swift
//  WeatherForecastAnswer
//
//  Created by chang sic jung on 13/06/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import Foundation

struct ShortRangeForecast {
    let skyCode: String
    let skyName: String
    let temperature: Double
    let date: Date
}

let shortRangeForecastSampleData = """
{
    "weather": {
        "forecast3days": [
        {
        "grid": {
        "longitude": "127.09776",
        "latitude": "37.11776",
        "city": "경기",
        "county": "오산시",
        "village": "청호동"
        },
        "timeRelease": "2019-06-12 17:00:00",
        "fcst3hour": {
        "wind": {
        "wdir4hour": "298.00",
        "wspd4hour": "1.50",
        "wdir7hour": "253.00",
        "wspd7hour": "1.00",
        "wdir10hour": "180.00",
        "wspd10hour": "0.30",
        "wdir13hour": "195.00",
        "wspd13hour": "1.10",
        "wdir16hour": "150.00",
        "wspd16hour": "0.80",
        "wdir19hour": "270.00",
        "wspd19hour": "0.70",
        "wdir22hour": "297.00",
        "wspd22hour": "1.30",
        "wdir25hour": "302.00",
        "wspd25hour": "2.80",
        "wdir28hour": "314.00",
        "wspd28hour": "2.80",
        "wdir31hour": "265.00",
        "wspd31hour": "1.20",
        "wdir34hour": "243.00",
        "wspd34hour": "1.10",
        "wdir37hour": "307.00",
        "wspd37hour": "1.00",
        "wdir40hour": "304.00",
        "wspd40hour": "1.80",
        "wdir43hour": "298.00",
        "wspd43hour": "2.70",
        "wdir46hour": "306.00",
        "wspd46hour": "2.60",
        "wdir49hour": "288.00",
        "wspd49hour": "2.90",
        "wdir52hour": "297.00",
        "wspd52hour": "2.70",
        "wdir55hour": "265.00",
        "wspd55hour": "1.20",
        "wdir58hour": "",
        "wspd58hour": "",
        "wdir61hour": "",
        "wspd61hour": "",
        "wdir64hour": "",
        "wspd64hour": "",
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
        "prob19hour": "0.00",
        "type22hour": "0",
        "prob22hour": "0.00",
        "type25hour": "0",
        "prob25hour": "0.00",
        "type28hour": "0",
        "prob28hour": "0.00",
        "type31hour": "0",
        "prob31hour": "0.00",
        "type34hour": "0",
        "prob34hour": "0.00",
        "type37hour": "0",
        "prob37hour": "0.00",
        "type40hour": "0",
        "prob40hour": "0.00",
        "type43hour": "0",
        "prob43hour": "0.00",
        "type46hour": "0",
        "prob46hour": "0.00",
        "type49hour": "0",
        "prob49hour": "20.00",
        "type52hour": "0",
        "prob52hour": "20.00",
        "type55hour": "0",
        "prob55hour": "30.00",
        "type58hour": "",
        "prob58hour": "",
        "type61hour": "",
        "prob61hour": "",
        "type64hour": "",
        "prob64hour": "",
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
        "code19hour": "SKY_S01",
        "name19hour": "맑음",
        "code22hour": "SKY_S01",
        "name22hour": "맑음",
        "code25hour": "SKY_S01",
        "name25hour": "맑음",
        "code28hour": "SKY_S01",
        "name28hour": "맑음",
        "code31hour": "SKY_S01",
        "name31hour": "맑음",
        "code34hour": "SKY_S01",
        "name34hour": "맑음",
        "code37hour": "SKY_S01",
        "name37hour": "맑음",
        "code40hour": "SKY_S01",
        "name40hour": "맑음",
        "code43hour": "SKY_S01",
        "name43hour": "맑음",
        "code46hour": "SKY_S01",
        "name46hour": "맑음",
        "code49hour": "SKY_S03",
        "name49hour": "구름많음",
        "code52hour": "SKY_S03",
        "name52hour": "구름많음",
        "code55hour": "SKY_S07",
        "name55hour": "흐림",
        "code58hour": "",
        "name58hour": "",
        "code61hour": "",
        "name61hour": "",
        "code64hour": "",
        "name64hour": "",
        "code67hour": "",
        "name67hour": ""
        },
        "temperature": {
        "temp4hour": "19.00",
        "temp7hour": "18.00",
        "temp10hour": "16.00",
        "temp13hour": "15.00",
        "temp16hour": "21.00",
        "temp19hour": "26.00",
        "temp22hour": "28.00",
        "temp25hour": "25.00",
        "temp28hour": "20.00",
        "temp31hour": "18.00",
        "temp34hour": "17.00",
        "temp37hour": "17.00",
        "temp40hour": "20.00",
        "temp43hour": "25.00",
        "temp46hour": "26.00",
        "temp49hour": "24.00",
        "temp52hour": "20.00",
        "temp55hour": "18.00",
        "temp58hour": "",
        "temp61hour": "",
        "temp64hour": "",
        "temp67hour": ""
        },
        "humidity": {
        "rh4hour": "65.00",
        "rh64hour": "",
        "rh67hour": "",
        "rh7hour": "80.00",
        "rh10hour": "85.00",
        "rh13hour": "90.00",
        "rh16hour": "65.00",
        "rh19hour": "50.00",
        "rh22hour": "45.00",
        "rh25hour": "50.00",
        "rh28hour": "65.00",
        "rh31hour": "80.00",
        "rh34hour": "85.00",
        "rh37hour": "90.00",
        "rh40hour": "70.00",
        "rh43hour": "55.00",
        "rh46hour": "50.00",
        "rh49hour": "55.00",
        "rh52hour": "65.00",
        "rh55hour": "80.00",
        "rh58hour": "",
        "rh61hour": ""
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
        "rain60hour": "",
        "rain66hour": "",
        "snow60hour": "",
        "snow66hour": ""
        },
        "fcstdaily": {
        "temperature": {
        "tmax1day": "",
        "tmax2day": "28.00",
        "tmax3day": "26.00",
        "tmin1day": "",
        "tmin2day": "15.00",
        "tmin3day": "16.00"
        }
        }
        }
        ]
    },
    "common": {
        "alertYn": "N",
        "stormYn": "N"
    },
    "result": {
        "code": 9200,
        "requestUrl": "/weather/forecast/3days?appKey=bd934d80-9cc6-4ecb-a821-b12a8584bd5e&lat=37.11776&lon=127.09776",
        "message": "성공"
    }
}
""".data(using: .utf8)!

