//
//  WeatherSymbol.swift
//  ForecastLine
//
//  Created by alex on 11.07.2021.
//

import Foundation

enum WeatherSymbol: String {
    case clearDay = "clear-day"
    case clearNight = "clear-night"
    case partlyCloudyDay = "partly-cloudy-day"
    case partlyCloudyNight = "partly-cloudy-night"
    case cloudy
    case fog
    case rain
    case sleet
    case snow
    case wind
    case umbrella
    case isEmpty
    
    var icon: String {
        switch self {
        case .clearDay:
            return "sun.max"
        case .clearNight:
            return "moon"
        case .cloudy:
            return "cloud"
        case .fog:
            return "cloud.fog"
        case .partlyCloudyDay:
            return "cloud.sun"
        case .partlyCloudyNight:
            return "cloud.moon"
        case .rain:
            return "cloud.rain"
        case .sleet:
            return "cloud.sleet"
        case .snow:
            return "cloud.snow"
        case .wind:
            return "wind"
        case .umbrella:
            return "umbrella"
        case .isEmpty:
            return "nosign"
        }
    }
}
