//
//  CurrentForecast.swift
//  WeatherForecast
//
//  Created by giftbot on 13/06/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import Foundation

// API URL: https://api2.sktelecom.com/weather/current/hourly

/// 현재 기상예보 - 1시간 단위
// Codable 객체 만들기 기록
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
    // 배열 뺄 떄 nestedUnkeyedContainer 쓰기
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

