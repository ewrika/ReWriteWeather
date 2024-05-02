//
//  WeatherWeek.swift
//  ReWriteWeather
//
//  Created by Георгий Борисов on 02.05.2024.
//

import Foundation

struct WeatherWeek:Codable{
    var list: [Weather]
    var city: City
    
    static func empty() -> WeatherWeek {
        WeatherWeek(list: [], city: City())
        }
    
}
struct Weather: Codable {
    var dt: Int
    var main: TodayWeather
    var weather: [WeatherIcon]
    var wind: WeatherWind
    var dt_txt: String
    init() {
        dt = 0
        main = TodayWeather()
        weather = [WeatherIcon()]
        wind = WeatherWind()
        dt_txt = ""
    }
}


struct TodayWeather: Codable {
    var temp: Double
    var feels_like: Double
    var pressure: Int
    var humidity: Int
    init() {
        temp = 0
        feels_like = 0
        pressure = 0
        humidity = 0
    }
}

struct WeatherIcon: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
    
    init() {
        id = 0
        main = ""
        description = ""
        icon = ""
    }
}



struct WeatherWind: Codable {
    var speed: Double
    init(){
        speed = 0
    }
}



struct City: Codable {
    var id: Int
    var name: String
    var coord: WeatherCoord    
    
    init() {
        id = 0
        name = ""
        coord = WeatherCoord()
    }
    
}
