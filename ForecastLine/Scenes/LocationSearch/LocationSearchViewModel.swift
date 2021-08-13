//
//  LocationSearchViewModel.swift
//  ForecastLine
//
//  Created by alex on 26.07.2021.
//

import Foundation

final class LocationSearchViewModel {
    
    private(set) var locations = [Location]()
    
    private let repository: SavedLocationsRepository

    init(repository: SavedLocationsRepository)
    {
        self.repository = repository
    }
}

//self.locations = [Location(id: "1", name: "Prague", latitude: 50.0755, longitude: 14.4378), Location(id: "2", name: "New York", latitude: 40.7128, longitude: -74.006)]

extension LocationSearchViewModel {
    func getSavedLocations() {
        
        repository.getLocations { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let locations):
                self.locations = locations
            case .failure(let error):
                // presentError(error) implementing alert presenter
                print(error.localizedDescription)
            }
        }
    }
    
    func saveLocation(location: Location) {
        if !locations.contains(location) {
            locations.append(location)
        }
        
        saveLocations()
    }
    
    private func saveLocations() {
        repository.saveLocations(locations: locations) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let empty):
                print("success saving locations")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
