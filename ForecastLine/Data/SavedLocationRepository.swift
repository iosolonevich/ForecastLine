//
//  SavedLocationRepository.swift
//  ForecastLine
//
//  Created by alex on 12.07.2021.
//

import Foundation

typealias FetchSavedLocationsCompletion = (Result<[Location], Error>) -> Void
typealias SaveLocationsCompletion = (Result<Empty, Error>) -> Void

protocol SavedLocationsRepository {
    func getLocations(completion: FetchSavedLocationsCompletion?)
    func saveLocations(locations: [Location], completion: SaveLocationsCompletion?)
}

final class SavedLocationsRepositoryImpl {
    
    private let defaults: UserDefaults
    private var jsonHelper: SerializeHelper
    
    init(userDefaults: UserDefaults, jsonHelper: SerializeHelper) {
        self.defaults = userDefaults
        self.jsonHelper = jsonHelper
    }
}

private extension String {
    static let savedLocationRepoKey = "SavedLocations"
}

extension SavedLocationsRepositoryImpl: SavedLocationsRepository {
    
    func getLocations(completion: FetchSavedLocationsCompletion?) {
        let codedLocations = defaults.object(forKey: .savedLocationRepoKey)
        if codedLocations == nil {
            completion?(Result.success([Location]()))
            return
        }
        
        guard let codedLocations = codedLocations as? Data else {
            completion?(Result.failure(UserDefaultsError.readUserDefaults))
            return
        }
        
        guard let decodedLocations = try? jsonHelper.decoder.decode([Location].self, from: codedLocations) else {
            completion?(Result.failure(SerializerError.jsonDecodingError))
            return
        }
        
        completion?(Result.success(decodedLocations))
    }
    
    func saveLocations(locations: [Location], completion: SaveLocationsCompletion?) {
        
        guard let encoded = try? self.jsonHelper.encoder.encode(locations) else {
            completion?(Result.failure(SerializerError.jsonEncodingError))
            return
        }
        
        self.defaults.set(encoded, forKey: .savedLocationRepoKey)
        DispatchQueue.main.async {
            completion?(Result.success(Empty()))
        }
    }
}
