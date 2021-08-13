//
//  LocationDailyForecastListDisplayable.swift
//  ForecastLine
//
//  Created by alex on 25.07.2021.
//

struct LocationDailyForecastListDisplayable {

    let dateFormatter = DateFormatterHelper.shared
    let coordinates: String
    let day: String
    let minTemp: String
    let maxTemp: String
    let precipitation: String
    let symbol: WeatherSymbol

    init(object: LocationDailyForecast) {
        coordinates = object.coordinates
        day = dateFormatter.getTimeStringFromUnixTime(timeIntervalSince1970: object.dateTimestamp,
                                                      timezone: .CET,
                                                      format: .day)
        maxTemp = object.maxTemperature.temperatureString
        minTemp = object.minTemperature.temperatureString
        precipitation = object.precipitationProbability.percentString
        symbol = object.symbol
    }
}
