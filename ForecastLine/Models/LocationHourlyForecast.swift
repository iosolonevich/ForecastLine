//
//  LocationHourlyForecast.swift
//  ForecastLine
//
//  Created by alex on 25.07.2021.
//

struct LocationHourlyForecast: Codable {
    
//    let coordinates: String
    let dateTimestamp: Double
    let temperature: Double
    let precipitationProbability: Double
    let icon: String
    
    var symbol: WeatherSymbol {
        return WeatherSymbol(rawValue: icon) ?? .isEmpty
    }
}
