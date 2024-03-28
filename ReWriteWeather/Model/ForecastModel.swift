//
//  ForecastModel.swift
//  ReWriteWeather
//
//  Created by Георгий Борисов on 28.03.2024.
//

import Foundation

struct ForecastResponse: Codable {
    var city: City
    var list: [ForecastList]
}

struct City: Codable {
    var name: String?
    var country: String?
    var sunrise: Int?
    var sunset: Int?
    var timezone: Int?
    var coord: Coordinates?
}

struct ForecastList: Codable {
    var dt: Int?
    var main: MainForecast?
    var weather: [WeatherForecast]?
    var clouds: Clouds?
    var wind: WindForecast?
    var dt_txt: String?
}

struct MainForecast: Codable {
    var temp: Double?
    var feels_like: Double?
    var temp_min: Double?
    var temp_max: Double?
    var sea_level: Int?
    var grnd_level: Int?
    var humidity: Int?
}

struct WeatherForecast: Codable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}

struct Clouds: Codable {
    var clouds: Int?
}


struct WindForecast: Codable {
    var speed: Double?
    var deg: Int?
}

struct Coordinates: Codable {
    var lat: Double?
    var lon: Double?
}
