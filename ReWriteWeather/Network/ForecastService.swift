//
//  ForecastService.swift
//  ReWriteWeather
//
//  Created by Георгий Борисов on 28.03.2024.
//

import Foundation


class ForecastService {
    
    
    
    func getForecast(city: String, completion: @escaping (ForecastResponse?) -> ()) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=c9fe9ab82fefc53a641582c72462beaf&units=metric") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            let forecastResponse = try? JSONDecoder().decode(ForecastResponse.self, from: data)
            
            if let forecastResponse = forecastResponse {
                let forecastData = forecastResponse
                completion(forecastData)
                
            } else {
                completion(nil)
            }
            
        }.resume()
    }
    
    func getForecastByZipCode(zip: String, country_code: String, completion: @escaping (ForecastResponse?) -> ()) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?zip=\(zip),\(country_code)&appid=c9fe9ab82fefc53a641582c72462beaf&units=metric") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            let forecastResponse = try? JSONDecoder().decode(ForecastResponse.self, from: data)
            
            if let forecastResponse = forecastResponse {
                let forecastData = forecastResponse
                completion(forecastData)
                
            } else {
                completion(nil)
            }
            
        }.resume()
    }
}
