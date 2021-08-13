//
//  LocationSearchCreator.swift
//  ForecastLine
//
//  Created by alex on 26.07.2021.
//

import UIKit

struct LocationSearchCreator {
    
    func getController() -> LocationSearchController {
        
        let userDefaults = UserDefaults.standard
        let jsonHelper = SerializeHelper.shared
        let searchResultsController = LocationSearchResultsCreator().getController()
        let searchController = UISearchController(searchResultsController: searchResultsController)
        let repository = SavedLocationsRepositoryImpl(userDefaults: userDefaults, jsonHelper: jsonHelper)
        let viewModel = LocationSearchViewModel(repository: repository)
        let cellManager = LocationSearchCellManager()
        let controller = LocationSearchController(viewModel: viewModel, cellManager: cellManager, searchController: searchController)
        return controller
    }
}
