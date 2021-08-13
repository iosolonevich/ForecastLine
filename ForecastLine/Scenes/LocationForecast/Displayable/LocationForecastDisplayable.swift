//
//  LocationForecastDisplayable.swift
//  ForecastLine
//
//  Created by alex on 25.07.2021.
//

import Foundation

struct LocationForecastDisplayable {
    
    let id: String
    let name: String
    let temp: String
    let symbol: WeatherSymbol
    
    init(object: LocationWeather) {
        id = object.id
        name = object.locationName
        temp = object.temperature.temperatureStringKelvinToCelsius
        symbol = object.symbol
    }
}
