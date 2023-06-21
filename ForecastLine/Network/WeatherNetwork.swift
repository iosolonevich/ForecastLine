//
//  WeatherService.swift
//  ForecastLine
//
//  Created by alex on 11.07.2021.
//

import Foundation

class WeatherService {
    
    private let client: APIClient
    
    init(apiKey: String) {
        self.client = APIClient(apiKey: apiKey)
    }
    
    ///
    /// Get the weather with async
    ///
    func getWeather(lat: Double, lon: Double, options: WeatherOptionsProtocol) async -> OWMResponse? {
        do {
            let results: OWMResponse = try await client.fetchWeatherAsync(param: "lat=\(lat)&lon=\(lon)", options: options)
            return results
        } catch {
            return nil
        }
    }
    
    ///
    /// Get the weather with completion handler
    ///
    func getWeather(lat: Double, lon: Double, options: WeatherOptionsProtocol, completion: @escaping (OWMResponse?) -> Void) {
        Task {
            let results: OWMResponse? = await getWeather(lat: lat, lon: lon, options: options)
            DispatchQueue.main.async {
                completion(results)
            }
        }
    }
}
