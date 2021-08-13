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
        let networking = WeatherNetworkImpl()
        let fakeNetworking = WeatherNetworkFakeImpl()
        let viewModel = LocationForecastViewModel(locationDetails: locationDetails, networking: networking, fakeNetworking: fakeNetworking)
        let controller = LocationForecastController(viewModel: viewModel, cellManager: cellManager)
        return controller
    }
}
