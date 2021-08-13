//
//  LocationHourlyForecastListDisplayable.swift
//  ForecastLine
//
//  Created by alex on 25.07.2021.
//

struct LocationHourlyForecastListDisplayable {

    let dateFormatter = DateFormatterHelper.shared
//    let coordinates: String
    let hour: String
    let temp: String
    let precipitation: String
    let symbol: WeatherSymbol
    
    init(object: LocationHourlyForecast) {
//        coordinates = object.coordinates
        hour = dateFormatter.getTimeStringFromUnixTime(timeIntervalSince1970: object.dateTimestamp,
                                                       timezone: .CET,
                                                       format: .hour)
        temp = object.temperature.temperatureStringKelvinToCelsius
        precipitation = object.precipitationProbability.percentString
        symbol = object.symbol
    }
}
