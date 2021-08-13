//
//  Request.swift
//  ForecastLine
//
//  Created by alex on 11.07.2021.
//

import Foundation

enum HTTPMethod: String {
    case get
}

struct Request<T: Codable> {
    
    typealias CodableApiCompletion = (Result<T, Error>) -> Void
    
    let url: String
    let method: String
    let parameters: [String: Any]?
    let completion: CodableApiCompletion?
    
    init(url: String,
         method: HTTPMethod,
         parameters: [String: Any]? = nil,
         completion: CodableApiCompletion? = nil) {
        self.url = url
        self.method = method.rawValue
        self.parameters = parameters
        self.completion = { result in
            DispatchQueue.main.async {
                completion?(result)
            }
        }
    }
}
