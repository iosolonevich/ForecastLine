//
//  LocationHourlyForecastListDisplayable.swift
//  ForecastLine
//
//  Created by alex on 25.07.2021.
//

struct LocationHourlyForecastListDisplayable {

    let dateFormatter = DateFormatterHelper.shared
    let hour: String
    let temp: String
    let precipitation: String
    let symbol: WeatherSymbol
    
    init(object: LocationHourlyForecast? = nil) {
        hour = dateFormatter.getTimeStringFromUnixTime(
            timeIntervalSince1970: object?.dateTimestamp ?? 0,
            timezone: .CET,
            format: .hour
        )
        temp = object?.temperature.temperatureString ?? "-"
        precipitation = object?.precipitationProbability.percentString ?? "-"
        symbol = object?.symbol ?? .isEmpty
    }
}
