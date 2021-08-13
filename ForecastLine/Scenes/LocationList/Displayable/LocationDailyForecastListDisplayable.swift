//
//  LocationDailyForecastListDisplayable.swift
//  ForecastLine
//
//  Created by alex on 25.07.2021.
//

struct LocationDailyForecastListDisplayable {

    let dateFormatter = DateFormatterHelper.shared
//    let coordinates: String
    let day: String
    let tempValue: Int
    let temp: String
    let minTemp: String
    let maxTemp: String
    let precipitation: String
    let symbol: WeatherSymbol

    init(object: LocationDailyForecast) {
//        coordinates = object.coordinates
        day = dateFormatter.getTimeStringFromUnixTime(timeIntervalSince1970: object.dateTimestamp,
                                                      timezone: .CET,
                                                      format: .dayShort)
        tempValue = Int(object.temperature)
        temp = object.temperature.temperatureStringKelvinToCelsius
        maxTemp = object.maxTemperature.temperatureStringKelvinToCelsius
        minTemp = object.minTemperature.temperatureStringKelvinToCelsius
        precipitation = object.precipitationProbability.percentString
        symbol = object.symbol
    }
}
