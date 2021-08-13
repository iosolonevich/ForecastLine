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
        let networking = WeatherNetworkImpl()
        let fakeNetworking = WeatherNetworkFakeImpl()
        let viewModel = LocationListViewModel(networking: networking, fakeNetworking: fakeNetworking, repository: repository)
        let cellManager = LocationListCellManager()
        let controller = LocationListController(viewModel: viewModel, cellManager: cellManager)
        return controller
    }
}
