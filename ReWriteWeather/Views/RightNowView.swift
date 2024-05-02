//
//  RightNowView.swift
//  ReWriteWeather
//
//  Created by Георгий Борисов on 29.04.2024.
//

import SwiftUI

struct RightNowView: View {
    
    @StateObject var weatherModel: WeatherLocation

    var body: some View {
        VStack(alignment:.leading){
            Text("Right Now")
                .font(.system(size: 40))
                .font(.title)
                .fontWeight(.bold)
            
        }
        
        TabView{
            WeatherNow(weatherDay: weatherModel.weatherDay)
            moreInformation(weatherDay: weatherModel.weatherDay)
            
        }
        .frame(width: 330,height: 220)
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        }
}

#Preview {
    RightNowView(weatherModel: WeatherLocation())
}


struct moreInformation: View {
    var weatherDay: WeatherDay
    init(weatherDay: WeatherDay) {
        self.weatherDay = weatherDay
    }
    
    var body: some View {
        HStack{
            VStack{
                ZStack{
                    Circle()
                        .frame(width: 30,height: 30)
                        .foregroundStyle(.indigo)
                    Image(systemName: "arrow.up.forward").foregroundColor(.white)
                }
                Text(Image(systemName: "drop.fill")).foregroundStyle(.gray).font(.system(size:30))

                ZStack{
                    Ellipse().fill(LinearGradient(gradient:Gradient(colors: [.red,.yellow,.green]),startPoint: .top,endPoint: .bottom))
                        .frame(width: 30,height: 30)
                    Image(systemName: "arrow.down")
                        .foregroundColor(.white)
                }
                
            }
            VStack(alignment:.leading,spacing:25){
                
                Text("\(String(format: "%.0f", weatherDay.wind.speed))mph winds from the southwest")
                
                Text("Humidity \(weatherDay.main.humidity) %")
                    .offset(y:-7)
                Text("Pressure \(weatherDay.main.pressure)")
            
            }
        }.padding()
    }
}

struct WeatherNow:View{
    var weatherDay: WeatherDay
    var iconName: String
    var temp: Int
    var feels_like: Int
    
    init(weatherDay: WeatherDay) {
        self.weatherDay = weatherDay
        self.iconName = WeatherLocation.weatherIcon(icon: weatherDay.weather.first!.icon)
        self.temp = Int(weatherDay.main.temp)
        self.feels_like = Int(weatherDay.main.feels_like)
    }
    
    var body: some View{
        VStack(alignment:.leading) {
            HStack{
                Image(iconName.capitalized)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150,height: 150)
                
                VStack {
                    Text("\(temp)°")
                        .font(.system(size: 50))
                        .fontWeight(.bold)
                    
                    Text("Feels like \(feels_like)°")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                    
                }
            }
        }

    }
}
