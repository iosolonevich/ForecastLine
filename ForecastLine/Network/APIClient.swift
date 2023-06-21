//
//  APIClient.swift
//  ForecastLine
//
//  Created by alex on 11.07.2021.
//

import Foundation

enum APIError: Error, LocalizedError {
    
    case unknown, apiError(reason: String), parserError(reason: String), networkError(from: URLError)
    
    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown error"
        case .apiError(let reason), .parserError(let reason):
            return reason
        case .networkError(let from):
            return from.localizedDescription
        }
    }
}

///
/// https://openweathermap.org/api/one-call-api
///
class APIClient {
    
    let apiKey: String
    let sessionManager: URLSession
    
    let mediaType = "application/json; charset=utf-8"
    let oneCallURL = "https://api.openweathermap.org/data/2.5/onecall"
    
    init(apiKey: String) {
        self.apiKey = "appid=" + apiKey
        self.sessionManager = {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 30  // seconds
            configuration.timeoutIntervalForResource = 30 // seconds
            return URLSession(configuration: configuration)
        }()
    }
    
    private func baseUrl(_ locParam: String, options: WeatherOptionsProtocol) -> URL? {
        URL(string: "\(oneCallURL)?\(locParam)\(options.toParamString())&\(apiKey)")
    }

    func fetchWeatherAsync<T: Decodable>(param: String, options: WeatherOptionsProtocol) async throws -> T {
        
        guard let url = baseUrl(param, options: options) else {
            throw APIError.apiError(reason: "bad URL")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(mediaType, forHTTPHeaderField: "Accept")
        request.addValue(mediaType, forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.unknown
            }
            if (httpResponse.statusCode == 401) {
                throw APIError.apiError(reason: "Unauthorized")
            }
            if (httpResponse.statusCode == 403) {
                throw APIError.apiError(reason: "Resource forbidden")
            }
            if (httpResponse.statusCode == 404) {
                throw APIError.apiError(reason: "Resource not found")
            }
            if (405..<500 ~= httpResponse.statusCode) {
                throw APIError.apiError(reason: "Client error")
            }
            if (500..<600 ~= httpResponse.statusCode) {
                throw APIError.apiError(reason: "Server error")
            }
            if (httpResponse.statusCode != 200) {
                throw APIError.networkError(from: URLError(.badServerResponse))
            }
            let results = try JSONDecoder().decode(T.self, from: data)
            return results
        }
        catch {
            throw APIError.parserError(reason: "JSON error")
        }
    }
}
