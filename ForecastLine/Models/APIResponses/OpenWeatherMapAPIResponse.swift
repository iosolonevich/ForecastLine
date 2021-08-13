//
//  LocationListAPIResponse.swift
//  ForecastLine
//
//  Created by alex on 11.07.2021.
//


// MARK: - WeatherModel
struct OpenWeatherMapAPIResponse: Codable {
    let lat, lon: Double
    let timezone: String
    let timezoneOffset: Int
    let current: Current
    let minutely: [Minutely]
    let hourly: [Current]
    let daily: [Daily]
    let alerts: [Alert]?

    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case timezoneOffset = "timezone_offset"
        case current, minutely, hourly, daily, alerts
    }
    
//    init(lat: Double? = nil, lon: Double? = nil, timezone: String? = nil, timezoneOffset: Int? = nil,
//         current: Current? = nil, minutely: [Minutely]? = nil, hourly: [Current]? = nil,
//         daily: [Daily]? = nil, alerts: [Alert]? = nil) {
//        self.lat = lat
//        self.lon = lon
//        self.timezone = timezone
//        self.timezoneOffset = timezoneOffset
//        self.current = current
//        self.minutely = minutely
//        self.hourly = hourly
//        self.daily = daily
//        self.alerts = alerts
//    }
}

// MARK: - Alert
struct Alert: Codable {
    let senderName, event: String
    let start, end: Int
    let alertDescription: String

    enum CodingKeys: String, CodingKey {
        case senderName = "sender_name"
        case event, start, end
        case alertDescription = "description"
    }
}

// MARK: - Current
struct Current: Codable {
    let dt: Int
    let sunrise, sunset: Int?
    let temp, feelsLike: Double
    let pressure, humidity: Int
    let dewPoint, uvi: Double
    let clouds, visibility: Int
    let windSpeed: Double
    let windDeg: Int
    let weather: [Weather]
    let windGust, pop: Double?
    let rain: Rain?

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case uvi, clouds, visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather
        case windGust = "wind_gust"
        case pop, rain
    }
}

// MARK: - Rain
struct Rain: Codable {
    let the1H: Double

    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main: Main
    let weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

enum Main: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}

// MARK: - Daily
struct Daily: Codable {
    let dt, sunrise, sunset, moonrise: Int
    let moonset: Int
    let moonPhase: Double
    let temp: Temp
    let feelsLike: FeelsLike
    let pressure, humidity: Int
    let dewPoint, windSpeed: Double
    let windDeg: Int
    let windGust: Double
    let weather: [Weather]
    let clouds: Int
    let pop: Double
    let rain: Double?
    let uvi: Double

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather, clouds, pop, rain, uvi
    }
}

// MARK: - FeelsLike
struct FeelsLike: Codable {
    let day, night, eve, morn: Double
}

// MARK: - Temp
struct Temp: Codable {
    let day, min, max, night: Double
    let eve, morn: Double
}

// MARK: - Minutely
struct Minutely: Codable {
    let dt, precipitation: Int
}
