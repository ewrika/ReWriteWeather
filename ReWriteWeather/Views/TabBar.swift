    //
    //  TabBar.swift
    //  ReWriteWeather
    //
    //  Created by Георгий Борисов on 28.03.2024.
    //

    import SwiftUI
    import MapKit

    struct TabBar: View {
        @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
        var body: some View {            
                    TabView() {
                        HomeView()
                            .tabItem { Label("Forecast",systemImage: "chart.bar.xaxis") }.tag(2)

                       SettingsView()
                            .tabItem { Label("Settings",systemImage: "gearshape.fill") }.tag(4)
                    }
                }
            }

    #Preview {
        TabBar()
    }
