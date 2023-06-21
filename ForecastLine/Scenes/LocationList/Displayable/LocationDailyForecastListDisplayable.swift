//
//  LocationDailyForecastListDisplayable.swift
//  ForecastLine
//
//  Created by alex on 25.07.2021.
//

struct LocationDailyForecastListDisplayable {

    let dateFormatter = DateFormatterHelper.shared
    let day: String
    let tempValue: Int
    let temp: String
    let minTemp: String
    let maxTemp: String
    let precipitation: String
    let symbol: WeatherSymbol

    init(object: LocationDailyForecast? = nil) {
        day = dateFormatter.getTimeStringFromUnixTime(
            timeIntervalSince1970: object?.dateTimestamp ?? 0,
            timezone: .CET,
            format: .dayShort
        )
        tempValue = Int(object?.temperature ?? 0) 
        temp = object?.temperature.temperatureString ?? "-"
        maxTemp = object?.maxTemperature.temperatureString ?? "-"
        minTemp = object?.minTemperature.temperatureString ?? "-"
        precipitation = object?.precipitationProbability.percentString ?? "-"
        symbol = object?.symbol ?? .isEmpty
    }
}
