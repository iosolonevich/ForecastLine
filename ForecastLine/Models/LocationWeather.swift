//
//  LocationForecast.swift
//  ForecastLine
//
//  Created by alex on 11.07.2021.
//

import Foundation

struct LocationWeather: Codable {
    
    let id: String
    let locationName: String
    let latitude: Double
    let longitude: Double
    let temperature: Double
    let icon: String
    
    var symbol: WeatherSymbol {
        return WeatherSymbol(rawValue: icon) ?? .isEmpty
    }
}
