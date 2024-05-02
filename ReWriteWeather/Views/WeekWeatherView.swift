//
//  WeekWeatherView.swift
//  ReWriteWeather
//
//  Created by Георгий Борисов on 03.05.2024.
//

import SwiftUI

struct WeekWeatherView: View {
    
    var weatherModel: WeatherLocation
    var weatherSeveralDays: [Weather]

    init(weatherModel: WeatherLocation) {
        self.weatherModel = weatherModel
        self.weatherSeveralDays = self.weatherModel.getWeatherWeekDays()
    }
    
    var body: some View {
        VStack(alignment: .center) {
            ForEach(weatherSeveralDays, id: \.dt) { weather in
                WeekView(weather: weather)
            }
            Spacer()
        }
    }
}

#Preview {
    WeekWeatherView(weatherModel: WeatherLocation())
}

struct WeekView:View{
    var weather: Weather
    var iconName: String
    var day: String
    var speed: Int
    
    init(weather: Weather) {
        self.weather = weather
        self.iconName = WeatherLocation.weatherIcon(icon: self.weather.weather.first!.icon)
        self.day = WeatherLocation.getDay(weather: weather)
        self.speed = Int(weather.wind.speed)
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .center) {
                Text("\(day)")
                    .font(.title3)
                    .foregroundColor(.gray)
            }
            Image("\(iconName.capitalized)")
                .resizable()
                .frame(width: 50, height: 50)
            Text("\(speed)mph winds.")
        }
    }
    
}
