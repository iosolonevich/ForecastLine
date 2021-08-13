//
//  LocationForecastCellManager.swift
//  ForecastLine
//
//  Created by alex on 24.07.2021.
//

import UIKit

enum CellManagerItemType {
    case hourlyForecast
    case dailyForecast
}

protocol CellManagerItem {
    var type: CellManagerItemType { get }
    var rowCount: Int { get }
}

final class LocationForecastCellManager: NSObject {

    private var items = [CellManagerItem]()
}

extension LocationForecastCellManager: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].rowCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]
        switch item.type {
        case .hourlyForecast: return buildHourlyForecastItemCell(item: item, tableView: tableView, indexPath: indexPath)
        case .dailyForecast: return buildDailyForecastItemCell(item: item, tableView: tableView, indexPath: indexPath)
        }
    }
}

extension LocationForecastCellManager {
    
    func setup(with hourlyForecast: [LocationHourlyForecastListDisplayable], _ dailyForecast: [LocationDailyForecastListDisplayable]) {
        
        let hourlyForecastItem = LocationForecastCellManagerHourlyItem(hourlyForecast: hourlyForecast)
        items.append(hourlyForecastItem)
        let dailyForecastItem = LocationForecastCellManagerDailyItem(dailyForecast: dailyForecast)
        items.append(dailyForecastItem)
    }
}

extension LocationForecastCellManager {
    
    func buildHourlyForecastItemCell(item: CellManagerItem, tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        
//        if let item = item as? LocationForecastCellManagerHourlyItem {
//            let cell = tableView.dequeue(with: LocationForecastCollectionViewTableViewCell.self, for: indexPath)
//            cell.setup(with: item.hourlyForecast[indexPath.row])
//            return cell
//        }
        return UITableViewCell()
    }
    
    func buildDailyForecastItemCell(item: CellManagerItem, tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        
        if let item = item as? LocationForecastCellManagerDailyItem {
            let cell = tableView.dequeue(with: LocationForecastTableViewCell.self, for: indexPath)
            cell.setup(with: item.dailyForecast[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}
