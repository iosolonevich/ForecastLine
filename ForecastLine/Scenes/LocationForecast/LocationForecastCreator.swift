//
//  LocationForecastCreator.swift
//  ForecastLine
//
//  Created by alex on 24.07.2021.
//

import Foundation

struct LocationForecastCreator {
    
    func getController(with locationDetails: LocationWeather) -> LocationForecastController {
        
        let cellManager = LocationForecastCellManager()
        let weatherService = WeatherService(apiKey: "1d5922c8842bc718cedf8cb0289f43a7")
        let viewModel = LocationForecastViewModel(locationDetails: locationDetails, weatherService: weatherService)
        let controller = LocationForecastController(viewModel: viewModel, cellManager: cellManager)
        return controller
    }
}
