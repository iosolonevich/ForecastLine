//
//  LocationListCellManager.swift
//  ForecastLine
//
//  Created by alex on 11.07.2021.
//

import UIKit

struct LocationListCellManager {
    
    func buildCell(tableView: UITableView, indexPath: IndexPath, locationWeathers: [LocationWeather])
    -> UITableViewCell {
        let locationWeathersDisplayable = convertToLocationWeathersDisplayable(locationWeathers: locationWeathers)
        let cell = tableView.dequeue(with: LocationListTableViewCell.self, for: indexPath)
        cell.setup(with: locationWeathersDisplayable[indexPath.row])
        return cell
    }
}

extension LocationListCellManager {
    func convertToLocationWeathersDisplayable(locationWeathers: [LocationWeather]) -> [LocationWeatherDisplayable] {
        return locationWeathers.map { LocationWeatherDisplayable(object: $0) }
    }
}
