//
//  LocationForecastCellManagerItems.swift
//  ForecastLine
//
//  Created by alex on 25.07.2021.
//

import Foundation

final class LocationForecastCellManagerHourlyItem: CellManagerItem {
    
    var type: CellManagerItemType {
        return .hourlyForecast
    }
    
    var rowCount: Int {
        return 1
    }
    
    var hourlyForecast: [LocationHourlyForecastListDisplayable]
    
    init(hourlyForecast: [LocationHourlyForecastListDisplayable]) {
        self.hourlyForecast = hourlyForecast
    }
}

final class LocationForecastCellManagerDailyItem: CellManagerItem {
    
    var type: CellManagerItemType {
        return .dailyForecast
    }
    
    var rowCount: Int {
        return dailyForecast.count
    }
    
    var dailyForecast: [LocationDailyForecastListDisplayable]
    
    init(dailyForecast: [LocationDailyForecastListDisplayable]) {
        self.dailyForecast = dailyForecast
    }
}
