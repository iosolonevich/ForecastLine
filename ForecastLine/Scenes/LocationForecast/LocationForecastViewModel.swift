//
//  LocationForecastViewModel.swift
//  ForecastLine
//
//  Created by alex on 25.07.2021.
//

import Foundation

typealias FetchForecastCompletion = (Result<LocationForecast, Error>) -> Void

final class LocationForecastViewModel {
    
    var forecastDisplayable: LocationForecastsDisplayable?
    
    private let locationDetails: LocationWeather
    private let networking: WeatherNetwork
    private let fakeNetworking: WeatherNetworkFake
    
    init(locationDetails: LocationWeather, networking: WeatherNetwork, fakeNetworking: WeatherNetworkFake)
    {
        self.locationDetails = locationDetails
        self.networking = networking
        self.fakeNetworking = fakeNetworking
    }
}

extension LocationForecastViewModel {
    
    func getLocationDetails() -> LocationForecastDisplayable {
        
        return LocationForecastDisplayable(object: locationDetails)
    }
    
    func getForecastsDisplayable() {
        
        //get forecast using fake networking and closures like in locationlistviewmodel etc.
        let coordinates = Coordinates(lat: locationDetails.latitude, lon: locationDetails.longitude)
        fetchLocationWeathers(in: coordinates.stringValue) { result in
            switch result {
            case .success(let forecast):
                let hourlyForecast = forecast.hourly
                let dailyForecast = forecast.daily
                let hourlyForecastDisplayable = hourlyForecast.map { LocationHourlyForecastListDisplayable(object: $0) }
                let dailyForecastDisplayable = dailyForecast.map { LocationDailyForecastListDisplayable(object: $0) }
                
                self.forecastDisplayable = LocationForecastsDisplayable(hourlyForecastDisplayable: hourlyForecastDisplayable, dailyForecastDisplayable: dailyForecastDisplayable)
            case .failure(let error):
                print(error)
            }
        }
    }
}

private extension LocationForecastViewModel {
    
    private func fetchLocationWeathers(in coordinates: String, completion: FetchForecastCompletion?) {
        
        fakeNetworking.fetchFakeCurrentWeatherForLocation(coordinates: coordinates) { result in
            switch result {
            case .success(let apiResponse):
                let hourlyForecast = apiResponse.hourly.map {
                        LocationHourlyForecast(
//                            coordinates: coordinates,
                            dateTimestamp: Double($0.dt),
                            temperature: $0.temp,
                            precipitationProbability: $0.dewPoint,
                            icon: $0.weather.first?.icon ?? "")
                }
                let dailyForecast = apiResponse.daily.map {
                    LocationDailyForecast(
//                        coordinates: coordinates,
                        dateTimestamp: Double($0.dt),
                        temperature: $0.temp.day,
                        maxTemperature: $0.temp.max,
                        minTemperature: $0.temp.min,
                        precipitationProbability: $0.dewPoint,
                        icon: $0.weather.first?.icon ?? "")
                }
                completion?(.success(LocationForecast(hourly: hourlyForecast, daily: dailyForecast)))
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
    
}
