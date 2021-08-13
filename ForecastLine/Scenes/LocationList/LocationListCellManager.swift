//
//  LocationListCellManager.swift
//  ForecastLine
//
//  Created by alex on 11.07.2021.
//

import UIKit

struct LocationListCellManager {
    
    func buildCell(tableView: UITableView, indexPath: IndexPath, locationForecasts: [LocationWeather])
    -> UITableViewCell {
        let locationForecastsDisplayable = convertToLocationForecastsDisplayable(locationForecasts: locationForecasts)
        let cell = tableView.dequeue(with: LocationListTableViewCell.self, for: indexPath)
        cell.setup(with: locationForecastsDisplayable[indexPath.row])
        return cell
    }
}

extension LocationListCellManager {
    func convertToLocationForecastsDisplayable(locationForecasts: [LocationWeather]) -> [LocationWeatherDisplayable] {
        return locationForecasts.map { LocationWeatherDisplayable(object: $0) }
    }
}
