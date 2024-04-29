//
//  SettingsView.swift
//  OpenWeather
//
//  Created by Георгий Борисов on 16.03.2024.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.colorScheme) private var scheme
    @State private var changeTheme: Bool = false
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    var body: some View {
        NavigationStack {

            
            Form {
                Section(header: Text("DISPLAY OPTIONS")) {
                    NavigationLink{
                        DonateView()
                    }label: {
                        HStack {
                            ZStack{
                                RoundedRectangle(cornerRadius: 5)
                                    .frame(width: 30, height: 30)
                                    .foregroundStyle(.orange)
                                Image(systemName: "globe")
                                    .foregroundStyle(.white)
                            }
                            Text("Units")
                        }
                    }
                    Button{
                        changeTheme.toggle()
                    }label: {
                        HStack {
                            ZStack{
                                RoundedRectangle(cornerRadius: 5)
                                    .frame(width: 30, height: 30)
                                    .foregroundStyle(.orange)
                                Image(systemName: "moon.fill")
                            }
                            Text("Appereance(click)")
                        }
                        .preferredColorScheme(userTheme.colorScheme)
                    }.buttonStyle(.plain)
                    .sheet(isPresented: $changeTheme, content: {
                        UnitsView(scheme: scheme)
                            .presentationDetents([.height(410)])
                            .presentationBackground(.clear)
                    })
                }
                
                Section(header: Text("EXCLUSIVE EXTRAS")) {
                    NavigationLink{
                        DonateView()
                    }label: {
                        HStack {
                            ZStack{
                                RoundedRectangle(cornerRadius: 5)
                                    .frame(width: 30, height: 30)
                                    .foregroundStyle(.indigo)
                                Image(systemName: "heart.fill")
                                    .foregroundStyle(.white)
                            }
                            Text("Updgrade Now")
                        }
                    }


                }
            }.navigationTitle("Settings")
        }
                .navigationBarTitle("Settings")
            }
        }


#Preview {
    SettingsView()
}

struct Platform{
    let name:String
    let imageName:String
    let color:Color
}
