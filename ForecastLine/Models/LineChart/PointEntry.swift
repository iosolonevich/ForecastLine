//
//  PointEntry.swift
//  ForecastLine
//
//  Created by alex on 13.08.2021.
//

import UIKit

struct PointEntry: Comparable {
    
    let value: Int
    let axisLabel: String
    let pointLabel: String
    
    let feelsLike: String? = ""
//    let icon: String?
    let symbol: WeatherSymbol
    
    static func < (lhs: PointEntry, rhs: PointEntry) -> Bool {
        return lhs.value < rhs.value
    }
}
