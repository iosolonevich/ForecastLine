//
//  LocationSearchCellManager.swift
//  ForecastLine
//
//  Created by alex on 26.07.2021.
//

import UIKit

final class LocationSearchCellManager {
    
    func buildCell(tableView: UITableView, indexPath: IndexPath, locations: [Location]) -> UITableViewCell {
//        let locationsDisplayable = convertToLocationsDisplayable(locations: locations)
        let cell = tableView.dequeue(with: UITableViewCell.self, for: indexPath)
//        cell.setup(with: locationsDisplayable[indexPath.row])
        cell.textLabel?.text = locations[indexPath.row].name
        return cell
    }
}

//extension LocationSearchCellManager {
//    func convertToLocationsDisplayable(locations: [Location]) -> [LocationDisplayable] {
//        return locations.map {
//            LocationDisplayable(object: $0)
//        }
//    }
//}
