//
//  HomeView.swift
//  ReWriteWeather
//
//  Created by Георгий Борисов on 28.03.2024.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    
    @StateObject var weatherModel: WeatherLocation

    @State var showDonate = false
    
    @State var searchField = ""
    var body: some View {
        
        VStack() {
                HStack() {
                    Text(weatherModel.getCity())
                        .foregroundStyle(.green)
                    Spacer()
                    Image(systemName: "square.and.arrow.up")
                        .foregroundStyle(.green)
                }.padding(.horizontal)
                Divider()
                    .overlay(Color(.green))
                
                
            ScrollView{
                
                RightNowView(weatherModel: weatherModel)
                    
                    Button("Complications that refresh more often!\n Updgrade now ->")
                    {
                        showDonate.toggle()
                    }.font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.white, lineWidth: 0)
                        )                .padding()
                        .background(Color.indigo)
                        .cornerRadius(25)
                        .sheet(isPresented:$showDonate){
                            DonateView()
                        }
                
                
                VStack(alignment:.leading){
                    Text("This Morning")
                        .bold()
                        .font(.title)
                        .padding()
                    TodayWeatherView(weatherModel: weatherModel)
                }.padding()
                
                VStack(alignment:.leading){
                    Text("This week")
                        .bold()
                        .font(.title)
                        .padding()
                    WeekWeatherView(weatherModel:weatherModel)
                }.padding()
            }
            .preferredColorScheme(userTheme.colorScheme)
        }
        
    }
}
            
#Preview {
    HomeView(weatherModel: WeatherLocation())
}

