//
//  Double+StringConverters.swift
//  ForecastLine
//
//  Created by alex on 11.07.2021.
//

import Foundation

extension Double {
    
    var temperatureString: String {
        return "\(Int(self.rounded()))°"
    }
    
    var percentString: String {
        return "\(Int((self * 100).rounded()))%"
    }
    
    static let weekInterval: Double = 604800
}
