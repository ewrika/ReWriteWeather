//
//  WeatherApi.swift
//  ReWriteWeather
//
//  Created by Георгий Борисов on 02.05.2024.
//

import Foundation

let APIKey = "c9fe9ab82fefc53a641582c72462beaf"
let coordsUrl = "https://api.openweathermap.org/data/2.5/weather?"
let cityUrl = "https://api.openweathermap.org/data/2.5/weather?"
let weatherIconUrl = "https://openweathermap.org/img/wn/"
let defaultWeatherIcon = "https://openweathermap.org/img/wn/02d@2x.png"


struct WeatherApi {
    
    static func getWeatherDay(lat: Double, lon: Double) -> String {
        return "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=\(APIKey)&units=metric"
    }
    
    static func getWeatherWeek(lat: Double, lon: Double) -> String {
        return "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(APIKey)&units=metric"
    }
}


class NetworkManager<T: Codable> {
    static func fetchWeather(for url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                guard error == nil else {
                    print(String(describing: error))
                    if let error = error?.localizedDescription {
                        completion(.failure(.error(err: error)))
                    }
                    return
                }
                
                do {
                    let json = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(json))
                } catch let err {
                    print(String(describing: err))
                    completion(.failure(.decodingError(err: err.localizedDescription)))
                }
            }.resume()
        }
}

enum NetworkError: Error {
    case invalidResponse
    case invalidData
    case decodingError(err: String)
    case error(err: String)
}
