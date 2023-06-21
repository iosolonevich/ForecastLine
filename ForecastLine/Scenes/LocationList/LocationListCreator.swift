//
//  LocationListCreator.swift
//  ForecastLine
//
//  Created by alex on 11.07.2021.
//

import Foundation

struct LocationListCreator {
    
    func getController() -> LocationListController {
        
        let userDefaults = UserDefaults.standard
        let jsonHelper = SerializeHelper.shared
        let repository = SavedLocationsRepositoryImpl(userDefaults: userDefaults, jsonHelper: jsonHelper)
        let weatherService = WeatherService(apiKey: "1d5922c8842bc718cedf8cb0289f43a7")
        let viewModel = LocationListViewModel(weatherService: weatherService, repository: repository)
        let cellManager = LocationListCellManager()
        let controller = LocationListController(viewModel: viewModel, cellManager: cellManager)
        return controller
    }
}
