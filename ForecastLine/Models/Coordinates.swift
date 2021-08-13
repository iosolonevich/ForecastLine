//
//  Coordinates.swift
//  ForecastLine
//
//  Created by alex on 14.07.2021.
//

import Foundation

struct Coordinates {
    var lat, lon: Double
    
    var stringValue: String {
        return "\(lat),\(lon)"
    }
}
