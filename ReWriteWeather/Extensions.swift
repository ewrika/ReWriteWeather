//
//  Extensions.swift
//  ReWriteWeather
//
//  Created by Георгий Борисов on 28.03.2024.
//

import Foundation
import SwiftUI

extension Color {
    static let underline = LinearGradient(gradient: Gradient(colors: [.red.opacity(0), .indigo, .white.opacity(0)]), startPoint: .leading, endPoint: .trailing)
}

enum Theme:String,CaseIterable{
    case systemDefault = "Default"
    case light = "Light"
    case dark = "Dark"
    
    func color(_ scheme: ColorScheme) -> Color {
        switch self{
        case .systemDefault:
            return scheme == .dark ? .moon : .sun
        case .light:
            return .sun
        case .dark:
            return .moon
        }
    }

    var colorScheme:ColorScheme?{
        switch self{
        case .systemDefault:
            return nil
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}
