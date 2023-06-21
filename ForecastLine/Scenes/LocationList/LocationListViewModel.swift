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
    var locationForecasts = [LocationForecast]()
    
    var delegate: LocationListViewModelDelegate?
    
    private let weatherService: WeatherService
    private let repository: SavedLocationsRepository
    
    init(weatherService: WeatherService, repository: SavedLocationsRepository) {
        self.weatherService = weatherService
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
            weatherService.getWeather(
                lat: location.latitude,
                lon: location.longitude,
                options: WeatherRequestOptions.current()
            ) { response in
                let locationWeatherResult = self.convertToLocationWeatherResult(location: location, response: response)
                responses.append(locationWeatherResult)
                
                //TODO: put outside the loop
                self.handleLocationWeatherResponse(locations: locations, responses: responses, completion: completion)
            }
        }
    }
    
    private func convertToLocationWeatherResult(location: Location, response: OWMResponse?) -> Result<LocationWeather, Error> {
        guard let response, let locationWeather = convertToLocationWeather(location: location, apiResponse: response) else {
            return .failure(MissingAPIData())
        }
        return .success(locationWeather)
    }
    
    private func convertToLocationWeather(location: Location, apiResponse: OWMResponse) -> LocationWeather? {
//        guard let temp = apiResponse.current.temp else { return nil }
        return LocationWeather(
            id: location.id,
            locationName: location.name,
            latitude: location.latitude,
            longitude: location.longitude,
            temperature: apiResponse.current.temp,
            hourly: apiResponse.hourly?.map {
                LocationHourlyForecast(
                    dateTimestamp: Double($0.dt),
                    temperature: $0.temp,
                    precipitationProbability: $0.dewPoint,
                    icon: $0.weather.first?.icon ?? ""
                )
            },
            daily: apiResponse.daily?.map {
                LocationDailyForecast(
                    dateTimestamp: Double($0.dt),
                    temperature: $0.temp.day,
                    maxTemperature: $0.temp.max,
                    minTemperature: $0.temp.min,
                    precipitationProbability: $0.dewPoint,
                    icon: $0.weather.first?.icon ?? ""
                )
            },
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
