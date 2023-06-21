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
    private let weatherService: WeatherService
    
    init(locationDetails: LocationWeather, weatherService: WeatherService)
    {
        self.locationDetails = locationDetails
        self.weatherService = weatherService
    }
}

extension LocationForecastViewModel {
    
    func getLocationDetails() -> LocationForecastDisplayable {
        
        return LocationForecastDisplayable(object: locationDetails)
    }
    
    func getForecastsDisplayable() {
        
        //get forecast using fake networking and closures like in locationlistviewmodel etc.
        let coordinates = Coordinates(lat: locationDetails.latitude, lon: locationDetails.longitude)
        fetchLocationWeathers(in: coordinates) { result in
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
    
    private func fetchLocationWeathers(in coordinates: Coordinates, completion: FetchForecastCompletion?) {
        
        weatherService.getWeather(lat: coordinates.lat, lon: coordinates.lon, options: WeatherRequestOptions.current()) { apiResponse in
                
            if let hourly = apiResponse?.hourly, let daily = apiResponse?.daily {
                let hourlyForecast = hourly.map {
                    LocationHourlyForecast(
                        dateTimestamp: Double($0.dt),
                        temperature: $0.temp,
                        precipitationProbability: $0.dewPoint,
                        icon: $0.weather.first?.icon ?? "")
                }
                let dailyForecast = daily.map {
                    LocationDailyForecast(
                        dateTimestamp: Double($0.dt),
                        temperature: $0.temp.day,
                        maxTemperature: $0.temp.max,
                        minTemperature: $0.temp.min,
                        precipitationProbability: $0.dewPoint,
                        icon: $0.weather.first?.icon ?? "")
                }
                completion?(.success(LocationForecast(hourly: hourlyForecast, daily: dailyForecast)))
            } else {
                completion?(.failure(MissingAPIData()))
            }
        }
    }
}
