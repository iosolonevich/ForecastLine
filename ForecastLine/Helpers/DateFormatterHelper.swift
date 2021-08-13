//
//  DateFormatterHelper.swift
//  ForecastLine
//
//  Created by alex on 25.07.2021.
//

import Foundation

enum DateFormat: String {
    case full = "dd.MM.yyyy HH:mm"
    case long = "dd MMMM yyyy"
    case hour = "HH"
    case day = "dd.MM EEEE"
    case apiFormat = "yyyy-MM-DD'T'HH:mm:ss"
    case dayShort = "d.M"
}

enum TimeZoneID: String {
    case CET, GMT
}

final class DateFormatterHelper {

    static let shared = DateFormatterHelper()

    private let formatter: DateFormatter

    private init() {
        formatter = DateFormatter()
    }

    func formatToString(date: Date, format: DateFormat) -> String {
        formatter.dateFormat = format.rawValue
        return formatter.string(from: date)
    }

    func formatToDate(string: String, format: DateFormat) -> Date? {
        formatter.dateFormat = format.rawValue
        return formatter.date(from: string)
    }

    func getTimeStringFromUnixTime(timeIntervalSince1970: Double, timezone: TimeZoneID, format: DateFormat) -> String {
        let time = Date(timeIntervalSince1970: timeIntervalSince1970)
        formatter.dateFormat = format.rawValue
        formatter.timeZone = TimeZone(identifier: timezone.rawValue)
        return formatter.string(from: time)
    }
}
