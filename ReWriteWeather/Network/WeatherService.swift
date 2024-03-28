//
//  WeatherService.swift
//  ReWriteWeather
//
//  Created by Георгий Борисов on 28.03.2024.
//

import Foundation

import SwiftUI

 let APIKey = "c9fe9ab82fefc53a641582c72462beaf"
 let coordsUrl = "https://api.openweathermap.org/data/2.5/weather?"
 let cityUrl = "https://api.openweathermap.org/data/2.5/weather?"
 let weatherIconUrl = "https://openweathermap.org/img/wn/"
 let defaultWeatherIcon = "https://openweathermap.org/img/wn/02d@2x.png"


class WeatherService {
    /// Get the current weather forecast for a given city.
    func getWeather(city: String, byCoordinates: Bool, lat: Double, long: Double, completion: @escaping (WeatherResponse?) -> ()) {
        
        let coordsUrl = coordsUrl + "lat=\(lat)&lon=\(long)" + "&appid=\(APIKey)" + "&units=metric"
        let cityUrl = cityUrl + "q=\(city)" + "&appid=\(APIKey)" + "&units=metric"
        
        guard let url = byCoordinates ? URL(string: coordsUrl) : URL(string: cityUrl) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data)

            if let weatherResponse = weatherResponse {
                let weatherData = weatherResponse
                completion(weatherData)

            } else {
                completion(nil)
            }

        }.resume()
    }
    
    func getWeatherByZipCode(zip: String, country_code: String, completion: @escaping (WeatherResponse?) -> ()) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?zip=\(zip),\(country_code)&appid=c9fe9ab82fefc53a641582c72462beaf&units=metric") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data)
            
            if let weatherResponse = weatherResponse {
                let weatherData = weatherResponse
                completion(weatherData)
                
            } else {
                completion(nil)
            }
            
        }.resume()
    }
}
