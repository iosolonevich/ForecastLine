//
//  LocationListViewModel.swift
//  ForecastLine
//
//  Created by alex on 11.07.2021.
//

import Foundation

protocol LocationListViewModelDelegate {
    func didUpdateFavouriteLocationWeathers()
    func didFailWithError(error: Error)
}

typealias FetchWeatherCompletion = (Result<[LocationWeather], Error>) -> Void

final class LocationListViewModel {
    
    var locationWeathers = [LocationWeather]()
    
    var delegate: LocationListViewModelDelegate?
    
    private let networking: WeatherNetwork
    private let fakeNetworking: WeatherNetworkFake
    private let repository: SavedLocationsRepository
    
    init(networking: WeatherNetwork, fakeNetworking: WeatherNetworkFake, repository: SavedLocationsRepository)
    {
        self.networking = networking
        self.fakeNetworking = fakeNetworking
        self.repository = repository
    }
}

extension LocationListViewModel {
    
    func getSavedLocations() {
        
        repository.getLocations { result in
            switch result {
            case .success(let locations):
                self.delegateLocationsWeatherResponse(locations: locations, result: result)
            case .failure(let error):
                self.delegate?.didFailWithError(error: error)
            }
        }
    }
}


private extension LocationListViewModel {
    
    private func delegateLocationsWeatherResponse(locations: [Location], result: Result<[Location], Error>) {
        
        fetchLocationWeathers(locations: locations) { result in
            switch result {
            case .success(let locationWeathers):
                self.locationWeathers = locationWeathers
                self.delegate?.didUpdateFavouriteLocationWeathers()
            case .failure(let error):
                self.delegate?.didFailWithError(error: error)
            }
        }
    }
    
    private func fetchLocationWeathers(locations: [Location], completion: FetchWeatherCompletion?) {
        
        var responses = [Result<LocationWeather, Error>]()
        locations.forEach { location in
            let coordinates = Coordinates(lat: location.latitude, lon: location.longitude)
            
            fakeNetworking.fetchFakeCurrentWeatherForLocation(coordinates: coordinates.stringValue) { response in
                let locationWeatherResult = self.convertToLocationWeatherResult(location: location, response: response)
                responses.append(locationWeatherResult)
                self.handleLocationWeatherResponse(locations: locations, responses: responses, completion: completion)
            }
            
            
//            networking.fetchCurrentWeatherForLocation(coordinates: coordinates.stringValue) { response in
//                let locationWeatherResult = self.convertToLocationWeatherResult(location: location, response: response)
//                responses.append(locationWeatherResult)
//                self.handleLocationWeatherResponse(locations: locations, responses: responses, completion: completion)
//            }
            
        }
    }
    
    private func convertToLocationWeatherResult(location: Location, response: Result<OpenWeatherMapAPIResponse, Error>) -> Result<LocationWeather, Error> {
        
        switch response {
        case .failure(let error):
            return .failure(error)
        case .success(let apiResponse):
            guard let locationWeather = convertToLocationWeather(location: location, apiResponse: apiResponse) else {
                return .failure(MissingAPIData())
            }
            return .success(locationWeather)
        }
    }
    
    private func convertToLocationWeather(location: Location, apiResponse: OpenWeatherMapAPIResponse) -> LocationWeather? {
//        guard let temp = apiResponse.current.temp else { return nil }
        return LocationWeather(id: location.id,
                               locationName: location.name,
                               latitude: location.latitude,
                               longitude: location.longitude,
                               temperature: apiResponse.current.temp,
                               icon: apiResponse.current.weather.first?.icon ?? "")
    }
    
    private func handleLocationWeatherResponse(locations: [Location], responses: [Result<LocationWeather, Error>], completion: FetchWeatherCompletion?) {
        
        guard locations.count == responses.count else { return }
        let locationWeathersListResult = convertToLocationWeatherListResult(responses: responses)
        completion?(locationWeathersListResult)
    }
    
    private func convertToLocationWeatherListResult(responses: [Result<LocationWeather, Error>]) -> Result<[LocationWeather], Error> {
        var locationWeathers = [LocationWeather]()
        var errors = [Error]()
        responses.forEach { response in
            switch response {
            case .success(let locationWeather):
                locationWeathers.append(locationWeather)
            case .failure(let error):
                errors.append(error)
            }
        }
        
        if let firstError = errors.first {
            return .failure(firstError)
        }
        return .success(locationWeathers)
    }
}
