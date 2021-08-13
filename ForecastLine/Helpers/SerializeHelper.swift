//
//  SerializeHelper.swift
//  ForecastLine
//
//  Created by alex on 11.07.2021.
//

import Foundation

final class SerializeHelper {
    
    static let shared = SerializeHelper()
    
    let decoder: JSONDecoder
    let encoder: JSONEncoder
    
    private init() {
        decoder = JSONDecoder()
        encoder = JSONEncoder()
    }
}
