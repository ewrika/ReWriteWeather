//
//  DonateView.swift
//  OpenWeather
//
//  Created by Георгий Борисов on 17.03.2024.
//

import SwiftUI

struct DonateView: View {
    @Environment(\.dismiss) var dismiss
        var body: some View {
            
            NavigationView{
                VStack{
                    Text("Upgrade for Pro Features")
                        .fontWeight(.bold)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    Text("Tap a blue button below to instantly unlock our radar, Apple Watch app, data sources, air quality info, and much more.")
                        .multilineTextAlignment(.center)
                        .padding(.horizontal,60)
                        .padding(.vertical)
                    HStack{
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width:100,height: 100)
                            Text("$1.99\nmonthly").foregroundStyle(.white).bold()
                        }
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width:100,height: 100)
                            Text("$11.99\nmonthly").foregroundStyle(.white).bold()
                        }
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width:100,height: 100)
                            Text("$31.99\nmonthly").foregroundStyle(.white).bold()
                        }
                    }.foregroundStyle(.cyan)
                    Text("Montly and annual options include a 3-day free trial,so you can try it before you buy it!")
                        .multilineTextAlignment(.center)
                        .padding()
                        .padding(.horizontal,40)
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("Restore Previous Purchases")
                    })
                    
                    Text("Here's everthing you get")
                        .fontWeight(.bold)
                        .font(.title)
                    HStack{
                        VStack{
                            Image(systemName: "target").offset(y:-55)
                                .foregroundColor(.orange)
                                .font(.system(size: 40))
                            
                        }
                        VStack{
                            HStack {
                                Text("Advanced Radar").bold()
                                Spacer()
                            }
                            Text("See exactly what's coming your way with our pro radar. Unlock animations and future forecasts, plus map layers for cloud cover, tropical storms, lightning, wildfires, and more. (Coverage depends on location.)")
                        }
                    }.multilineTextAlignment(.leading)
                        .padding(.horizontal,10)
                    Spacer()
                }
                
                    .toolbar{
                        Button{
dismiss()
                        }label: {
                            Text("Done")
                                .font(.system(size: 20))
                                .font(.title)
                        }
                    }
                    
            }
        }
}

#Preview {
    DonateView()
}
