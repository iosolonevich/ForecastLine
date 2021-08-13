//
//  BaseNetworking.swift
//  ForecastLine
//
//  Created by alex on 11.07.2021.
//

import Foundation

class BaseNetwork {
    
    var client: APIClient
    
    init(client: APIClient = APIClient()) {
        self.client = client
    }
}
