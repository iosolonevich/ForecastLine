//
//  OWMResponse.swift
//  ForecastLine
//
//  Created by alex on 11.07.2021.
//

import Foundation

struct OWMResponse: Identifiable, Codable {
    let id = UUID()
    
    let lat, lon: Double
    let timezone: String
    let timezoneOffset: Int
    let current: Current
    let minutely: [Minutely]?
    let hourly: [Hourly]?
    let daily: [Daily]?
    let alerts: [Alert]?
    
    init(
        lat: Double = 0.0,
        lon: Double = 0.0,
        timezone: String = "GMT",
        timezoneOffset: Int = 0,
        current: Current,
        minutely: [Minutely]? = [],
        hourly: [Hourly]? = [],
        daily: [Daily]? = [],
        alerts: [Alert]? = []) {
            self.lat = lat
            self.lon = lon
            self.timezone = timezone
            self.timezoneOffset = timezoneOffset
            self.current = current
            self.minutely = minutely
            self.hourly = hourly
            self.daily = daily
            self.alerts = alerts
        }
    
    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone, current, minutely, hourly, daily, alerts
        case timezoneOffset = "timezone_offset"
    }
}

// MARK: - Current
struct Current: Codable {
    
    let dt, sunrise, sunset, pressure, humidity, clouds, visibility, windDeg: Int
    let temp, feelsLike, dewPoint, uvi, windSpeed: Double
    let windGust: Double?
    let weather: [Weather]
    let rain: Rain?
    let snow: Snow?
    
    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp, pressure, humidity, uvi, clouds, visibility, weather, rain, snow
        case feelsLike = "feels_like"
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
    }
}

struct Rain: Codable {
    let the1H: Double?
    let the3H: Double?
    
    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
        case the3H = "3h"
    }
    
    // for the case where we have: "rain": { }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let theRain = try? values.decode(Rain.self, forKey: .the1H) {
            self.the1H = theRain.the1H
        } else {
            self.the1H = nil
        }
        if let theRain = try? values.decode(Rain.self, forKey: .the3H) {
            self.the3H = theRain.the3H
        } else {
            self.the3H = nil
        }
    }
}

struct Snow: Codable {
    let the1H: Double?
    let the3H: Double?
    
    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
        case the3H = "3h"
    }
    
    // for the case where we have: "snow": { }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let theSnow = try? values.decode(Snow.self, forKey: .the1H) {
            self.the1H = theSnow.the1H
        } else {
            self.the1H = nil
        }
        if let theSnow = try? values.decode(Snow.self, forKey: .the3H) {
            self.the3H = theSnow.the3H
        } else {
            self.the3H = nil
        }
    }
}

// MARK: - Weather
struct Weather: Identifiable, Codable {
    let id: Int
    let main, weatherDescription, icon: String
    
    enum CodingKeys: String, CodingKey {
        case id, main, icon
        case weatherDescription = "description"
    }
}

// MARK: - Daily
struct Daily: Identifiable, Codable {
    let id = UUID()
    
    let dt, sunrise, sunset, pressure, humidity, windDeg, clouds: Int
    let dewPoint, windSpeed: Double
    let windGust, rain, snow, uvi: Double?
    let temp: DailyTemp
    let feelsLike: FeelsLike
    let weather: [Weather]
    let pop: Double?
    let visibility: Int?
    
    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp, pressure, humidity, visibility, weather, clouds, uvi, snow, rain, pop
        case feelsLike = "feels_like"
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
    }
}

// MARK: - FeelsLike
struct FeelsLike: Codable {
    let day, night, eve, morn: Double
}

// MARK: - DailyTemp
struct DailyTemp: Codable {
    let day, min, max, night, eve, morn: Double
}

// MARK: - Hourly
struct Hourly: Identifiable, Codable {
    let id = UUID()
    
    let dt, pressure, humidity, clouds, windDeg: Int
    let temp, feelsLike, dewPoint, windSpeed: Double
    let windGust: Double?
    let weather: [Weather]
    let rain: Rain?
    let snow: Snow?
    let pop: Double?
    let visibility: Int?
    
    enum CodingKeys: String, CodingKey {
        case dt, temp, pressure, humidity, visibility, clouds, weather, rain, snow, pop
        case feelsLike = "feels_like"
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
    }
}

// MARK: - Minutely
struct Minutely: Identifiable, Codable {
    let id = UUID()
    
    let dt: Int
    let precipitation: Double
    
    enum CodingKeys: String, CodingKey {
        case dt, precipitation
    }
}

// MARK: - Alert
struct Alert: Identifiable, Codable {
    let id = UUID()
    
    let senderName: String
    let event: String
    let start: Int
    let end: Int
    let description: String
    let tags: [String]?
    
    enum CodingKeys: String, CodingKey {
        case event, description, start, end, tags
        case senderName = "sender_name"
    }
}
