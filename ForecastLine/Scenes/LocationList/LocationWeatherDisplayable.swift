//
//  LocationForecastDisplayable.swift
//  ForecastLine
//
//  Created by alex on 11.07.2021.
//

struct LocationWeatherDisplayable {
    
    let id: String
    let name: String
    let temp: String
    let symbol: WeatherSymbol
    
    init(object: LocationWeather) {
        id = object.id
        name = object.locationName
        temp = object.temperature.temperatureString
        symbol = object.symbol
    }
}
