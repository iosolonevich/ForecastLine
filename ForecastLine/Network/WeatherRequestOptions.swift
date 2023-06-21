//
//  OWMOptions.swift
//  ForecastLine
//
//  Created by Alex Solonevich on 20.06.2023.
//

import Foundation

enum ExcludeMode: String {
    case current
    case minutely
    case hourly
    case daily
    case alerts
}

enum Units: String {
    case metric
    case imperial
    case standard
}

protocol WeatherOptionsProtocol {
    func toParamString() -> String
}

class WeatherRequestOptions: WeatherOptionsProtocol {
    
    private var excludeMode: [ExcludeMode]?
    private var units: Units?
    private var lang: String?
    
    init(excludeMode: [ExcludeMode], units: Units, lang: String) {
        self.excludeMode = excludeMode
        self.units = units
        self.lang = lang
    }
    
    // for everything
    init(lang: String = "en") { }
    
    // current weather
    static func current(lang: String = "en") -> WeatherRequestOptions {
        let options = WeatherRequestOptions()
        options.excludeMode = [.minutely]
        options.units = .metric
        options.lang = lang
        return options
    }
    
    // daily and current weather
    static func dailyForecast(lang: String = "en") -> WeatherRequestOptions {
        let options = WeatherRequestOptions()
        options.excludeMode = [.hourly, .minutely, .alerts]
        options.units = .metric
        options.lang = lang
        return options
    }
    
    // hourly and current weather
    static func hourlyForecast(lang: String = "en") -> WeatherRequestOptions {
        let options = WeatherRequestOptions()
        options.excludeMode = [.daily, .minutely, .alerts]
        options.units = .metric
        options.lang = lang
        return options
    }
    
    // daily, hourly and current weather
    static func fullForecast(lang: String = "en") -> WeatherRequestOptions {
        let options = WeatherRequestOptions()
        options.excludeMode = [.minutely]
        options.units = .metric
        options.lang = lang
        return options
    }
    
    // just the alerts
    static func alerts(lang: String = "en") -> WeatherRequestOptions {
        let options = WeatherRequestOptions()
        options.excludeMode = [.daily, .hourly, .minutely, .current]
        options.units = .metric
        options.lang = lang
        return options
    }
    
    func toParamString() -> String {
        var stringer = ""
        if let wUnits = units {
            stringer += "&units=" + wUnits.rawValue
        }
        if let wMode = excludeMode, !wMode.isEmpty {
            stringer += "&exclude=" + wMode.map{$0.rawValue}.joined(separator: ",")
        }
        if let wLang = lang {
            stringer += "&lang=" + wLang
        }
        return stringer
    }
}
