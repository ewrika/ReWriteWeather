//
//  WeatherViewModel.swift
//  ReWriteWeather
//
//  Created by Георгий Борисов on 28.03.2024.
//

import Foundation

import Combine

class WeatherViewModel: ObservableObject {
    private var temperatureService: WeatherService!
    @Published var city_name: String = ""
    @Published var weatherResponse = WeatherResponse.init(name: "", dt: 0, timezone: 0, main: Main(), wind: Wind(), weather: [], sys: Sys())
    @Published var dayTime: Bool = true
    var weatherDate: Int = 0

    init() {
        self.temperatureService = WeatherService()
        weatherDate = self.weatherResponse.dt
    }
    
    private func dateFormatter(timeStamp: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter.string(from: Date(timeIntervalSince1970: TimeInterval(timeStamp)))
    }
    
    private func getTime(timeStamp: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.timeZone = TimeZone(secondsFromGMT: self.weatherResponse.timezone)
        return formatter.string(from: Date(timeIntervalSince1970: TimeInterval(timeStamp)))
    }
    
    var date: String {
        return self.dateFormatter(timeStamp: self.weatherResponse.dt)
    }
    
    var sunrise: String {
        if let sunrise = self.weatherResponse.sys.sunrise {
            return self.getTime(timeStamp: sunrise)
        }
        return ""
    }
    
    var sunset: String {
        if let sunset = self.weatherResponse.sys.sunset {
            return self.getTime(timeStamp: sunset)
        }
        return ""
    }
    
    var temperature: String {
        if let temp = self.weatherResponse.main.temp {
            return String(format: "%.1f", temp)
        } else {
            return "0.0"
        }
    }
    
    var temp_min: String {
        if let temp_min = self.weatherResponse.main.temp_min {
            return String(format: "%.1f", temp_min)
        } else {
            return "0.0"
        }
    }
    
    var temp_max: String {
        if let temp_max = self.weatherResponse.main.temp_max {
            return String(format: "%.1f", temp_max)
        } else {
            return "0.0"
        }
    }
    
    var humidity: String {
        if let humidity = self.weatherResponse.main.humidity {
            return String(format: "%.1f", humidity)
        } else {
            return ""
        }
    }
    
    var wind_speed: String {
        if let wind_speed = self.weatherResponse.wind.speed {
            return String(format: "%.1f", wind_speed)
        } else {
            return "0.0"
        }
    }
    
    var country_code: String {
        if let country_code = self.weatherResponse.sys.country {
            return country_code
        } else {
            return ""
        }
    }
    
    var weatherIcon: String {
        if self.weatherResponse.weather.count != 0 {
            if let weatherIcon: String = self.weatherResponse.weather[0].icon {
                switch weatherIcon {
                    case "01d":
                        return "clear_sky_day"
                    case "01n":
                        return "clear_sky_night"
                    case "02d":
                        return "few_clouds_day"
                    case "02n":
                        return "few_clouds_night"
                    case "03d":
                        return "scattered_clouds"
                    case "03n":
                        return "scattered_clouds"
                    case "04d":
                        return "broken_clouds"
                    case "04n":
                        return "broken_clouds"
                    case "09d":
                        return "shower_rain"
                    case "09n":
                        return "shower_rain"
                    case "10d":
                        return "rain_day"
                    case "10n":
                        return "rain_night"
                    case "11d":
                        return "thunderstorm_day"
                    case "11n":
                        return "thunderstorm_night"
                    case "13d":
                        return "snow"
                    case "13n":
                        return "snow"
                    case "50d":
                        return "mist"
                    case "50n":
                        return "mist"
                    default:
                        return "clear_sky_day"
                }
            }
        }
        return "clear_sky_day"
    }
    
    var description: String {
        if self.weatherResponse.weather.count != 0 {
            if let description: String = self.weatherResponse.weather[0].description {
                return description
            }
        }
        return ""
        
    }
    
    var loadBackgroundImage: Bool {
        if let sunset = self.weatherResponse.sys.sunset {
            if self.weatherResponse.dt >= sunset {
                return false
            } else {
                return true
            }
        }
        return true
        
    }
    
    var city_country: String {
        if self.weatherResponse.name != "" && country_code != "" {
            return self.weatherResponse.name + ", " + self.country_code
        }
        return "-"
    }
    
    /// City name
    var cityName: String = ""
    var cityNameOnLoad: String = ""
    
    /// Search for city
    public func search(searchText: String) {
        
        if let city = searchText.addingPercentEncoding(withAllowedCharacters: .alphanumerics) {
            fetchWeather(by: city, byCoordinates: false, lat: 0.0, long: 0.0)
        }
    }
    
    public func searchOnLoad(city: String, lat: Double, long: Double) {
        if let city = city.addingPercentEncoding(withAllowedCharacters: .alphanumerics) {
            fetchWeather(by: city, byCoordinates: true, lat: lat, long: long)
        }
    }
    
    /// Get the current weather by zip code.
    public func getWeatherByZipCode(by zip: String, country_code: String) {
        self.temperatureService.getWeatherByZipCode(zip: zip, country_code: country_code) { weather in
            if let weather = weather {
                DispatchQueue.main.async {
                    self.weatherResponse = weather
                }
            }
        }
    }
    
    private func fetchWeather(by city: String, byCoordinates: Bool, lat: Double, long: Double) {
        self.temperatureService.getWeather(city: city, byCoordinates: byCoordinates, lat: lat, long: long) { weather  in
            
            if let weather = weather {
                DispatchQueue.main.async {
                    self.weatherResponse = weather
                }
            }
        }
    }
}
