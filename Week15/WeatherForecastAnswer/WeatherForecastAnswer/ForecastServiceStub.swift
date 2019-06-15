
// 샘플 데이터 처리를 위해
import Foundation

final class ForecastServiceStub: ForecastServiceType {
    func fetchCurrentForecast(
        latitude: Double,
        longitude: Double,
        completionHandler: @escaping (Result<CurrentForecast, ServiceError>) -> Void) {
        let data = currentForecastSampleData
        let forecast = try! CurrentForecast.decode(from: data)
        completionHandler(.success(forecast))
    }
    
    func fetchShortRangeForecast(
        latitude: Double,
        longitude: Double,
        completionHandler: @escaping (Result<[ShortRangeForecast], ServiceError>) -> Void) {
        
        let data = shortRangeForecastSampleData
        
        guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
            let weather = json["weather"] as? [String: Any],
            let forecast3days = (weather["forecast3days"] as? [[String: Any]])?.first,
            let fcst3hour = forecast3days["fcst3hour"] as? [String: Any]
            else { return completionHandler(.failure(.invalidFormat)) }
        
        guard let timeRelease = forecast3days["timeRelease"] as? String,
            let sky = fcst3hour["sky"] as? [String: String],
            let temperature = fcst3hour["temperature"] as? [String: String]
            else { return completionHandler(.failure(.invalidFormat)) }
        // 기본 파싱 완료
        
        // 실제 필요한 예보 자료 파싱
        var forecastArr: [ShortRangeForecast] = []
        for hour in stride(from: 4, through: 67, by: 3) { // stride
            guard let skyCode = sky["code\(hour)hour"], !skyCode.isEmpty,
                let skyName = sky["name\(hour)hour"], !skyName.isEmpty,
                let tempStr = temperature["temp\(hour)hour"],
                let temp = Double(tempStr)
                else { continue }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            guard let releaseTime = dateFormatter.date(from: timeRelease) else { continue }
            let forecastTime = releaseTime.addingTimeInterval(TimeInterval(hour) * 3600)
            
            let forecast = ShortRangeForecast(
                skyCode: skyCode, skyName: skyName, temperature: temp, date: forecastTime
            )
            forecastArr.append(forecast)
        }
        
        completionHandler(.success(forecastArr))
    }
}
