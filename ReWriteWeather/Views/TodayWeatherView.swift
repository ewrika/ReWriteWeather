//
//  TodayWeatherView.swift
//  ReWriteWeather
//
//  Created by Георгий Борисов on 29.04.2024.
//

import SwiftUI

struct TodayWeatherView: View {
    
    @StateObject var weatherModel: WeatherLocation
    var body: some View {
        ScrollView(.horizontal){
            HStack{
                ForEach(weatherModel.getOneDayWeather(),id:\.dt){ weather in
                    todayView(weather:weather)
                    
                }
            }
        }
    }
}
#Preview {
    TodayWeatherView(weatherModel: WeatherLocation())
}

struct todayView: View {
    var weather: Weather
    var temp: Double
    var feels_like: Int
    var hour: String
    var iconName: String
    
    init(weather: Weather) {
        self.weather = weather
        self.temp = weather.main.temp
        self.feels_like = Int(weather.main.feels_like)
        self.hour = WeatherLocation.getHour(weather: weather)
        self.iconName = WeatherLocation.weatherIcon(icon: weather.weather.first!.icon)
    }
    var body: some View {
        
            VStack(){
                ZStack(){
                    Rectangle()
                        .fill(Color.cyan)
                        .frame(width: 150,height: 65)
                        .cornerRadius(10)
                        .rotationEffect(.degrees(90))
                    VStack{
                        Text("\(Int(temp))°")
                            .font(.title2)
                            .bold()
                    }
                }.frame(width: 65,height: 150)
                    .padding(.bottom)
                Text("\(hour)")
                    .font(.subheadline)
                    .fontWeight(.light)
                Image("\(iconName.capitalized)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50,height: 50)
            }.padding()
        }
    
}
