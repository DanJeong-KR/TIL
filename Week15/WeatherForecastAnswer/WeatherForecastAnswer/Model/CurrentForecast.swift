//
//  CurrentForecast.swift
//  WeatherForecastAnswer
//
//  Created by chang sic jung on 13/06/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import Foundation

struct CurrentForecast: Decodable, CustomStringConvertible {
    let grid: Grid
    let wind: Wind
    let precipitation: Precipitation
    let sky: Sky
    let temperature: Temperature
    let humidity: String
    let sunRiseTime: String
    let sunSetTime: String
    
    private enum CodingKeys: String, CodingKey {
        case weather
    }
    private enum WeatherKeys: String, CodingKey {
        case hourly
    }
    private enum HourlyKeys: String, CodingKey {
        case grid, wind, precipitation, sky, temperature, humidity, sunRiseTime, sunSetTime
    }
    
    struct Grid: Decodable {
        let city: String
        let county: String
        let village: String
    }
    struct Wind: Decodable {
        let wdir: String
        let wspd: String
    }
    struct Precipitation: Decodable {
        let sinceOntime: String
        let type: String
    }
    struct Sky: Decodable {
        let code: String
        let name: String
    }
    struct Temperature: Decodable {
        let tc: String
        let tmax: String
        let tmin: String
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let weather = try container.nestedContainer(keyedBy: WeatherKeys.self, forKey: .weather)
        // 배열 뺄 떄 nestedUnkeyedContainer
        var hourlyArr = try weather.nestedUnkeyedContainer(forKey: .hourly)
        let data = try hourlyArr.nestedContainer(keyedBy: HourlyKeys.self)
        
        grid = try data.decode(Grid.self, forKey: .grid)
        wind = try data.decode(Wind.self, forKey: .wind)
        precipitation = try data.decode(Precipitation.self, forKey: .precipitation)
        sky = try data.decode(Sky.self, forKey: .sky)
        temperature = try data.decode(Temperature.self, forKey: .temperature)
        humidity = try data.decode(String.self, forKey: .humidity)
        sunRiseTime = try data.decode(String.self, forKey: .sunRiseTime)
        sunSetTime = try data.decode(String.self, forKey: .sunSetTime)
    }
    
    var description: String {
        return """
        Grid : \(grid)
        Wind : \(wind)
        Precipitation : \(precipitation)
        Sky : \(sky)
        Temperature : \(temperature)
        Humidity : \(humidity)
        SunRiseTime : \(sunRiseTime)
        SunSetTime : \(sunSetTime)
        """
    }
}

let currentForecastSampleData = """
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
