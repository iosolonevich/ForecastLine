//
//  WeatherSymbol.swift
//  ForecastLine
//
//  Created by alex on 11.07.2021.
//

import Foundation

enum WeatherSymbol: String {
    case clearSky = "01d"
    case fewClouds = "02d"
    case scatteredClouds = "03d"
    case brokenClouds = "04d"
    case showerRain = "09d"
    case rain = "10d"
    case thunderstorm = "11d"
    case snow = "13d"
    case mist = "50d"
    
    case clearSkyNight = "01n"
    case fewCloudsNight = "02n"
    case scatteredCloudsNight = "03n"
    case brokenCloudsNight = "04n"
    case showerRainNight = "09n"
    case rainNight = "10n"
    case thunderstormNight = "11n"
    case snowNight = "13n"
    case mistNight = "50n"
    
    case isEmpty
    
    var icon: String {
        switch self {
        case .clearSky:
            return "sun.max"
        case .scatteredClouds, .brokenClouds:
            return "cloud"
        case .mist:
            return "cloud.fog"
        case .fewClouds:
            return "cloud.sun"
        case .rain:
            return "cloud.rain"
        case .thunderstorm:
            return "cloud.bolt"
        case .snow:
            return "cloud.snow"
        case .isEmpty:
            return "nosign"
        case .showerRain:
            return "cloud.drizzle"
        
        case .clearSkyNight:
            return "moon"
        case .fewCloudsNight:
            return "cloud.moon"
        case .scatteredCloudsNight, .brokenCloudsNight:
            return "cloud.fill"
        case .showerRainNight:
            return "cloud.drizzle.fill"
        case .rainNight:
            return "cloud.rain.fill"
        case .thunderstormNight:
            return "cloud.bolt.rain.fill"
        case .snowNight:
            return "cloud.snow.fill"
        case .mistNight:
            return "cloud.fog.fill"
        }
        
        
    }
}
