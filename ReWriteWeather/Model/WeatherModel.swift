//
//  WeatherModel.swift
//  ReWriteWeather
//
//  Created by Георгий Борисов on 28.03.2024.
//

import Foundation

import Foundation

struct WeatherResponse: Codable {
    var name: String
    var dt: Int
    var timezone: Int
    var main: Main
    var wind: Wind
    var weather: [Weather]
    var sys: Sys
}

struct Main: Codable {
    var temp: Double?
    var humidity: Double?
    var temp_min: Double?
    var temp_max: Double?
    var pressure: Int?
    var feels_like: Double?
}

struct Wind: Codable {
    var speed: Double?
}

struct Weather: Codable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}

struct Sys: Codable {
    var country: String?
    var sunrise: Int?
    var sunset: Int?
}
