//
//  WeatherDay.swift
//  ReWriteWeather
//
//  Created by Георгий Борисов on 02.05.2024.
//

import Foundation

struct WeatherDay:Codable{
    var coord: WeatherCoord
    var weather: [WeatherIcon]
    var main: WeatherCity
    var wind: WeatherWind
    
    static func empty() -> WeatherDay {
        WeatherDay(coord: WeatherCoord(), weather: [WeatherIcon()], main: WeatherCity(), wind: WeatherWind())
        }
}

struct WeatherCity:Codable{
    var temp: Double
    var feels_like: Double
    var pressure: Int
    var humidity: Int
    
    init(){
        temp = 0
        feels_like = 0
        pressure = 0
        humidity = 0
    }
}

struct WeatherCoord:Codable{
    var lon: Double
    var lat: Double
    init(){
        lon = 0
        lat = 0
    }
}


