//
//  SettingsListing.swift
//  ReWriteWeather
//
//  Created by Георгий Борисов on 01.05.2024.
//

import Foundation
import SwiftUI

struct SettingsListing:Identifiable{
    var id = UUID()
    var image:String
    var imageColor:Color
    var text:String
    var frameColor:Color
    var dostup:Bool
    var anotherText:String
}

let exclusive = [SettingsListing(image: "heart.fill", imageColor: .white, text: "Upgrade", frameColor: Color("Moon"),dostup: true,anotherText: ">"),
                 SettingsListing(image: "chart.bar.fill", imageColor: .white, text: "Forecast Data", frameColor: Color("Moon"),dostup: false,anotherText:"Weather >"),
             SettingsListing(image: "gyroscope", imageColor: .white, text: "Radar options", frameColor: Color("Moon"),dostup: false,anotherText: "Precipitation"),
             SettingsListing(image: "gearshape.fill", imageColor: .white, text: "App Icon", frameColor: Color("Moon"),dostup: false,anotherText: "Default"),
             SettingsListing(image: "paintpalette.fill", imageColor: .white, text: "Theme color", frameColor: Color("Moon"),dostup: false,anotherText: "Auto"),
             SettingsListing(image: "applewatch", imageColor: .white, text: "Apple Watch", frameColor: Color("Moon"),dostup: false,anotherText: ">")]

let FAQ = [SettingsListing(image: "questionmark.circle.fill", imageColor: .white, text: "FAQs", frameColor: Color(.cyan), dostup: true, anotherText: ">"),
           SettingsListing(image: "airplane", imageColor: .white, text: "Email Support", frameColor: Color(.cyan), dostup: true, anotherText: ">"),
           SettingsListing(image: "bird.circle.fill", imageColor: .white, text: "Tweet @helloweatherapp", frameColor: Color(.cyan), dostup: true, anotherText:">"),
           SettingsListing(image: "star.fill", imageColor: .white, text: "Rate This app", frameColor: Color(.cyan), dostup: true, anotherText: ">")]

let Other = [SettingsListing(image: "newspaper", imageColor: .white, text: "What's New?", frameColor: Color(.green), dostup: true, anotherText: ">"),
             SettingsListing(image: "lock", imageColor: .white, text: "Protecting Your Privacy", frameColor: Color(.green), dostup: true, anotherText: ">"),
             SettingsListing(image: "figure.and.child.holdinghands", imageColor: .white, text: "About the team", frameColor: Color(.green), dostup: true, anotherText: ">")]
