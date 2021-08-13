//
//  LocationDailyForecast.swift
//  ForecastLine
//
//  Created by alex on 25.07.2021.
//

struct LocationDailyForecast: Codable {

//    let coordinates: String
    let dateTimestamp: Double
    let temperature: Double
    let maxTemperature: Double
    let minTemperature: Double
    let precipitationProbability: Double
    let icon: String

    var symbol: WeatherSymbol {
        return WeatherSymbol(rawValue: icon) ?? .isEmpty
    }
}
