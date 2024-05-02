    //
    //  TabBar.swift
    //  ReWriteWeather
    //
    //  Created by Георгий Борисов on 28.03.2024.
    //

    import SwiftUI

struct TabBar: View {


    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    @StateObject private var weatherModel = WeatherLocation()

    var body: some View {
        TabView() {
            LocationsView(weatherModel: weatherModel)
                .tabItem{
                    Label("locations",systemImage: "location") }.tag(1)
            
            HomeView(weatherModel: weatherModel)
                .tabItem { Label("Forecast",systemImage: "chart.bar.xaxis") }.tag(2)
            
            SettingsView()
                .tabItem { Label("Settings",systemImage: "gearshape.fill") }.tag(4)
        }
    }
}

    #Preview {
        TabBar()
    }
