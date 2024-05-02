//
//  WeatherLocation.swift
//  ReWriteWeather
//
//  Created by Георгий Борисов on 02.05.2024.
//

import Foundation
import CoreLocation

class WeatherLocation:ObservableObject {
    @Published var weatherWeek = WeatherWeek.empty().list
    @Published var weatherDay = WeatherDay.empty()
    
     var city = "Omsk"{
        didSet {
            getLocation()
        }
    }
    
    
    init() {
            getLocation()
    }
    
    public func setCity(city: String) {
        if city != "Your current location" {
            self.city = city
        } else {
            self.city = "Omsk"
        }
    }
    
    
    func getLocation(){
        CLGeocoder().geocodeAddressString(city) { (placemarks, error) in
            if let places = placemarks,
               let place = places.first {
                self.getWeather(coord: place.location?.coordinate)
                self.getWeatherWeek(coord: place.location?.coordinate)
            }
        }
    }
    
    private func getWeather(coord: CLLocationCoordinate2D?) {
            var urlString = ""
            if let coord = coord {
                urlString = WeatherApi.getWeatherDay(lat: coord.latitude, lon: coord.longitude)
            } else {
                urlString = WeatherApi.getWeatherDay(lat: 54.58, lon: 73.23)
            }
            getWeatherDay(city: city, for: urlString)
        }
    
    public func getCity() -> String {
        return city
    }
    
    private func getWeatherWeek(coord: CLLocationCoordinate2D?) {
        var urlString = ""
        if let coord = coord {
            urlString = WeatherApi.getWeatherWeek(lat: coord.latitude, lon: coord.longitude)
        } else {
            urlString = WeatherApi.getWeatherWeek(lat: 54.58, lon: 73.23)
        }
        getWeatherInternalWeek(city: city, for: urlString)
    }
    
    private func getWeatherDay(city: String, for urlString: String) {
            guard let url = URL(string: urlString) else {return}
            NetworkManager<WeatherWeek>.fetchWeather(for: url) { (result) in
                switch result {
                    case .success(let response):
                        DispatchQueue.main.async {
                            self.weatherWeek = response.list
                        }
                    case .failure(let error):
                        print(error)
                }
            }
        }
    
    private func getWeatherInternalWeek(city: String, for urlString: String) {
            guard let url = URL(string: urlString) else {return}
            NetworkManager<WeatherDay>.fetchWeather(for: url) { (result) in
                switch result {
                    case .success(let response):
                        DispatchQueue.main.async {
                            self.weatherDay = response
                        }
                    case .failure(let error):
                        print(error)
                }
            }
        }
    
    
    func getOneDayWeather() -> [Weather] {
        var arrayWeather: [Weather] = []
        
        for index in 0..<8 {
            if index < weatherWeek.count {
                    arrayWeather.append(weatherWeek[index])
                }
            }
        
        return arrayWeather
    }
    
    func getWeatherWeekDays() -> [Weather] {
        var arrayWeather: [Weather] = []
        
        if !weatherWeek.isEmpty {
            var nowDay = WeatherLocation.getDay(weather: weatherWeek.first!)
        
            for w in weatherWeek {
                let day = WeatherLocation.getDay(weather: w)
                if day != nowDay && WeatherLocation.getHour(weather: w) == "12pm"  {
                    arrayWeather.append(w)
                    nowDay = day
                }
            }
        }
        
        return arrayWeather
    }
 
    
    
    static func getSearchCity(city: String, isCity: @escaping (Bool) -> Void) {
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(city) { (placemarks, error) in
            var cityBool = false
            
            if error == nil {
                if let places = placemarks?.first, let _ = places.locality ?? places.administrativeArea {
                    cityBool = true
                    print("getSearchCity")
                }
            }
            isCity(cityBool)
        }
    }
    
    static func getDay(weather: Weather) -> String {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = format.date(from: weather.dt_txt) else {
            return ""
        }
        format.dateFormat = "dd"
        let day = format.string(from: date)
        return day
    }
    
    static func getHour(weather: Weather) -> String {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = format.date(from: weather.dt_txt) else {
            return ""
        }
        format.dateFormat = "ha"
        let hour = format.string(from: date)
        return hour.lowercased()
    }
    
    static func weatherIcon(icon: String) -> String {
            switch icon {
            case "01d":
                return "clear_sky_day"
            case "01n":
                return "Clear_Sky_Night"
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
