//
//  WeatherNetwork.swift
//  ForecastLine
//
//  Created by alex on 11.07.2021.
//

import Foundation

typealias FetchWeatherResponseCompletion = (Result<OpenWeatherMapAPIResponse, Error>) -> Void

protocol WeatherNetwork {
    
    func fetchCurrentWeatherForLocation(coordinates: String, completion: FetchWeatherResponseCompletion?)
}

final class WeatherNetworkImpl: BaseNetwork, WeatherNetwork {
    
    func fetchCurrentWeatherForLocation(coordinates: String, completion: FetchWeatherResponseCompletion?) {
        let urlParams = "https://api.openweathermap.org/data/2.5/"
        let httpRequest = Request(url: APIURL.owmUrlString + coordinates + urlParams, method: HTTPMethod.get, completion: completion)
    }
}
