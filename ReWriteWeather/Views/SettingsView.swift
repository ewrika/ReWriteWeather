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
                    }
                    )
                }
                
                Section(header: Text("EXCLUSIVE EXTRAS")){
                    ForEach(exclusive){ exclusive in
                        
                        HStack{
                            ZStack{
                                RoundedRectangle(cornerRadius: 5)
                                    .frame(width:30,height: 30)
                                    .foregroundStyle(Color(exclusive.frameColor))
                                Image(systemName: exclusive.image)
                                    .foregroundStyle(exclusive.imageColor)

                            }
                            Text(exclusive.text)
                            Spacer()
                            Text(exclusive.anotherText)
                                .fontWeight(.thin)
                        }
                        .opacity(exclusive.dostup ? 1:0.5)

                    }
                }
                
                Section(header: Text("have a question or need help?")){
                    ForEach(FAQ){ faq in
                        HStack{
                            ZStack{
                                RoundedRectangle(cornerRadius: 5)
                                    .frame(width:30,height: 30)
                                    .foregroundStyle(Color(faq.frameColor))
                                Image(systemName: faq.image)
                                    .foregroundStyle(faq.imageColor)
                            }
                            Text(faq.text)
                            Spacer()
                            Text(faq.anotherText)
                                .fontWeight(.thin)
                        }
                        .opacity(faq.dostup ? 1:0.7)
                    }
                }
                
                Section(header: Text("a few other tidbits")){
                    ForEach(Other){ other in
                        
                        HStack{
                            ZStack{
                                RoundedRectangle(cornerRadius: 5)
                                    .frame(width:30,height: 30)
                                    .foregroundStyle(Color(other.frameColor))
                                Image(systemName: other.image)
                                    .foregroundStyle(other.imageColor)

                            }
                            Text(other.text)
                            Spacer()
                            Text(other.anotherText)
                                .fontWeight(.thin)
                        }
                        .opacity(other.dostup ? 1:0.7)
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


