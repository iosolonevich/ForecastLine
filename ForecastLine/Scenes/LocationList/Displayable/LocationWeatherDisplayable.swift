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
    let hourly: [LocationHourlyForecastListDisplayable]
    let daily: [LocationDailyForecastListDisplayable]
    
    init(object: LocationWeather) {
        id = object.id
        name = object.locationName
        temp = object.temperature.temperatureStringKelvinToCelsius
        symbol = object.symbol
        hourly = object.hourly.map { LocationHourlyForecastListDisplayable(object: $0) }
        daily = object.daily.map { LocationDailyForecastListDisplayable(object: $0) }
    }
}
