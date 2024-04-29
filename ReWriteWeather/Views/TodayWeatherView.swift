//
//  TodayWeatherView.swift
//  ReWriteWeather
//
//  Created by Георгий Борисов on 29.04.2024.
//

import SwiftUI

struct TodayWeatherView: View {
    @StateObject var temperaturaVM = WeatherViewModel()
    
    var body: some View {
        VStack(alignment:.leading){
            Text("Today and tomorrow")
            
        }
    }
}

#Preview {
    TodayWeatherView()
}
