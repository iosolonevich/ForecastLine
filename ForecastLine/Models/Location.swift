//
//  Location.swift
//  ForecastLine
//
//  Created by alex on 12.07.2021.
//

import Foundation

struct Location: Codable, Equatable {
    
    let id: String
    let name: String
    let latitude: Double
    let longitude: Double
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        return lhs.name == rhs.name && lhs.latitude == rhs.latitude && lhs.longitude == lhs.longitude
    }
}


