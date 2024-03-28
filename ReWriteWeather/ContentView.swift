//
//  ContentView.swift
//  ReWriteWeather
//
//  Created by Георгий Борисов on 28.03.2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var forecastVM = ForecastViewModel()
    @ObservedObject var weatherVM = WeatherViewModel()
    @ObservedObject var lm = LocationManager()
    var body: some View {
        VStack(spacing: 28) {

            
            
            }
        }
    }


#Preview {
    ContentView()
}
