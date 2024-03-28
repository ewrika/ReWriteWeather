//
//  HomeView.swift
//  ReWriteWeather
//
//  Created by Георгий Борисов on 28.03.2024.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault

    @State var showAlert: Bool = false
    @State var showDonate = false
    @State private var selection = 0
    @ObservedObject var temperaturaVM = WeatherViewModel()
    @ObservedObject var forecastVM = ForecastViewModel()
    @ObservedObject var weatherVM = WeatherViewModel()

    @ObservedObject var lm = LocationManager()
    var placemark: String { return("\(lm.placemark?.locality ?? "")") }
    
    var subLocality: String { return("\(lm.placemark?.subLocality ?? "")") }
    
    var administrativeArea: String { return("\(lm.placemark?.administrativeArea ?? "")") }
    
    var latitude: Double  { return lm.location?.latitude ?? 0 }
    
    var longitude: Double { return lm.location?.longitude ?? 0 }
    
    var zip: String { return lm.placemark?.postalCode ?? "644001" }
    
    var country_code: String { return lm.placemark?.isoCountryCode ?? "RU" }
    
    var country_name: String { return lm.placemark?.country ?? "Russia" }
    @State var searchCity: Bool = false
    @State var searchField = ""
    var body: some View {
        
        VStack {
            HStack() {
                Text(temperaturaVM.city_country)
                    .foregroundStyle(.green)
                Spacer()
                Button(action: {
                    self.temperaturaVM.getWeatherByZipCode(by: self.zip, country_code: self.country_code)
                    self.showAlert = true
                }) {
                    Image(systemName: "arrow.clockwise")
                }
                .font(.system(size: 21))
                .foregroundColor(.green)
                .shadow(color: Color.black.opacity(0.20), radius: 5, x: 0, y: 6)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Твоя Локация"), message: Text("Ты находишься в  \(self.placemark), \(self.administrativeArea) \(self.country_name)"), dismissButton: .default(Text("Ok!")))
                }
                
            }.padding()
            VStack {
                Text("Search Locations")
                    .foregroundColor(.primary)
                HStack(spacing: 32) {
                    HStack {
                        TextField("Enter city name", text: self.$searchField) {
                            self.temperaturaVM.search(searchText: self.searchField)
                        }
                        .onAppear() {
                            self.temperaturaVM.getWeatherByZipCode(by: self.zip, country_code: self.country_code)
                        }
                        .padding()
                        
                        Button(action: { self.searchField = "" }) {
                            Text("Clear")
                        }
                        .padding(.trailing)
                    }
                    .onAppear() {
                        self.temperaturaVM.getWeatherByZipCode(by: self.zip, country_code: self.country_code)
                    }
                    .background(Color.white.opacity(0.30))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                }   //             .onAppear() {
//self.temperaturaVM.getWeatherByZipCode(by: self.zip, country_code: self.country_code)
        //        }
            }
            Divider()
            
            ScrollView(.vertical) {
                VStack(alignment:.center,spacing: 2){
                    Text("Прямо Сейчас")
                        .font(.system(size: 40))
                        .font(.title)
                        .fontWeight(.bold)
                }
                
                
                VStack(alignment:.center){
                    VStack(alignment:.leading) {
                        HStack{
                            Image(temperaturaVM.weatherIcon)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200,height: 200)
                                .offset(y:-20)
                            VStack {
                                Text(temperaturaVM.temperature)
                                    .font(.system(size: 50))
                                    .fontWeight(.bold)
                                
                                Text("Feels like " + temperaturaVM.temperature)
                                    .font(.system(size: 20))
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.secondary)
                                
                            }.offset(y:-20)
                        }
                    }
                }
                
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
                        Text(Image(systemName: "sun.horizon")).foregroundStyle(.yellow).font(.system(size:30))
                    }
                    VStack(alignment:.leading,spacing:25){
                        
                        Text(temperaturaVM.wind_speed + "mph winds from the southwest")
                        
                        Text(temperaturaVM.humidity + "%")
                        Text("Pressure 1005hPA and falling")
                        Text(temperaturaVM.sunrise + " -> " + temperaturaVM.sunset)
                    }
                }.padding()
                
                
                VStack{
                    Text("5-day forecast")
                        .font(.title3)
                        .fontWeight(.thin)
                        .offset(y:10)
                    
                    ScrollView(.horizontal){
                        HStack {
                            ForEach(self.forecastVM.forecastResponse.list, id: \.dt) { forecast in
                                
                                ZStack{
                
                                    // MARK : Card
                                    RoundedRectangle(cornerRadius: 10.0)
                                        .fill(Color.yellow.opacity( 1))
                                        .frame(width: 150,height: 180)
                                        .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.25), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/,x:5,y: 4)
                                    
                                    VStack(alignment:.center) {
                                        Text("\(self.forecastVM.dateFormatter(timeStamp: forecast.dt!))").font(.footnote)
                                        Text("\(self.forecastVM.getTime(timeStamp: forecast.dt!))")
                                            .font(.footnote)
                                            .foregroundColor(Color.secondary)
                                        Text("\(self.forecastVM.city), \(self.country_code)")
                                            .font(.footnote).foregroundColor(Color.gray)
  
                                        HStack {
                                            Image("\(self.forecastVM.getWeatherIcon(icon_name: (forecast.weather?[0].icon)!))")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                                .aspectRatio(contentMode: .fit)
                                            Text("\(self.forecastVM.formatDouble(temp: (forecast.main?.temp) ?? 0.0))°C")
                                        }
                                    }
                                }
                            }
                    }.onAppear() {
    
                        self.forecastVM.getForecastByZip(by: self.zip, country_code: self.country_code)
                    }
                        }.padding(.vertical ,20)
                    }.padding(.horizontal,10)
 
                    
                }
                
                // BUTTOn
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
            }
        .preferredColorScheme(userTheme.colorScheme)
        }
        
    }
            
        



            
#Preview {
    HomeView().environmentObject(WeatherViewModel())
}
