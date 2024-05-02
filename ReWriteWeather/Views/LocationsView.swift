//
//  LocationsView.swift
//  ReWriteWeather
//
//  Created by Георгий Борисов on 01.05.2024.
//

import SwiftUI

struct LocationsView: View {
    @State private var searchCity: String = ""
    @State private var isEditing = false
    @State private var cities = [
        CityList(image: "target", text: "Your current location"),
        CityList(image: "mappin.square", text: "New York, NY"),
        CityList(image: "mappin.square", text: "Moscow"),
        CityList(image: "mappin.square", text: "Omsk"),
        CityList(image: "mappin.square", text: "Tomsk")
    ]
    let weatherModel: WeatherLocation
    var body: some View {
        VStack {
            VStack(alignment:.leading) {
                HStack {
                    Text("Locations")
                        .fontWeight(.heavy)
                        .font(.title)
                    Spacer()
                }
                .padding()
                
                HStack {
                    TextField("Add a location...", text: $searchCity)
                        .padding(7)
                        .padding(.horizontal,25)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .overlay(
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .frame(minWidth: 0,maxWidth: .infinity,alignment: .leading)
                                    .padding(.leading,8)
                                
                                if isEditing {
                                    Button(action: {
                                        
                                    }
                                    ) {
                                        Image(systemName: "multiply.circle.fill")
                                            .foregroundColor(.gray)
                                            .padding(.trailing, 8)
                                    }
                                }
                            }
                        )
                        .padding(.horizontal, 10)
                        .onTapGesture {
                            withAnimation {
                                self.isEditing = true
                            }
                        }
                    if isEditing {
                        Button(action: {
                            self.isEditing = false
                            WeatherLocation.getSearchCity(city: searchCity, isCity: {
                                isCity in
                                cities.append(CityList(text: searchCity))
                            })
                        }) {
                            Text("Add")
                        }
                        .padding(.trailing, 10)
                        .transition(.move(edge: .trailing))
                    }
                }
            }
            
            Divider()
            
            ScrollView {
                ForEach(cities) { city in
                    HStack {
                        Button {
                            weatherModel.setCity(city: city.text)
                        } label: {
                            Image(systemName: city.image)
                                .font(.title)
                            Text(city.text)
                        }
                        .foregroundColor(.primary)
                        .padding(.horizontal,15)
                        .padding(.vertical,5)
                        Spacer()
                    }
                    .contextMenu {
                        Button(action: {
                            self.delete(city)
                        }) {
                            HStack {
                                Text("Delete")
                                Image(systemName: "trash")
                            }
                        }
                    }
                    
                    Divider()
                }
            }
        }
    }
    
    private func delete(_ city: CityList) {
        if let index = self.cities.firstIndex(where: { $0.id == city.id }) {
            self.cities.remove(at: index)
        }
    }
    
 
}


#Preview {
    LocationsView(weatherModel: WeatherLocation())
}


struct CityList:Identifiable{
    var id = UUID()
    var image="mappin.square"
    var text : String
}
