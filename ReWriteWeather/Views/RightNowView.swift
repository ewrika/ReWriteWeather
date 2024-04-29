//
//  RightNowView.swift
//  ReWriteWeather
//
//  Created by Георгий Борисов on 29.04.2024.
//

import SwiftUI

struct RightNowView: View {
    @ObservedObject var temperaturaVM = WeatherViewModel()

    var body: some View {
        VStack(alignment:.leading){
            Text("Right Now")
                .font(.system(size: 40))
                .font(.title)
                .fontWeight(.bold)
            
        }

        
        TabView{
            WeatherNow()
            moreInformation()
        }
        .frame(width: 330,height: 220)
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        }
}

#Preview {
    RightNowView()
}


struct moreInformation: View {
    @ObservedObject var temperaturaVM = WeatherViewModel()
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

                Text(Image(systemName: "sun.horizon")).foregroundStyle(.yellow).font(.system(size:30))
            }
            VStack(alignment:.leading,spacing:25){
                
                Text(temperaturaVM.wind_speed + "mph winds from the southwest")
                
                Text(temperaturaVM.humidity + "%")
                    .offset(y:-7)
                Text(temperaturaVM.sunrise + " -> " + temperaturaVM.sunset).offset(y:-15)
                    
            }
        }.padding()
    }
}

struct WeatherNow:View{
    @ObservedObject var temperaturaVM = WeatherViewModel()
    var body: some View{
        VStack(alignment:.leading) {
            HStack{
                Image(temperaturaVM.weatherIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200,height: 200)
                    .offset(y:-20)
                
                VStack {
                    Text(temperaturaVM.temperature+"°")
                        .font(.system(size: 50))
                        .fontWeight(.bold)
                    
                    Text("Feels like " + temperaturaVM.temperature_like + "°")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                    
                }.offset(y:-20)
            }
        }

    }
}
