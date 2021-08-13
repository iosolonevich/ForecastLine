//
//  LocationSearchResultsController.swift
//  ForecastLine
//
//  Created by alex on 03.08.2021.
//

import UIKit
import MapKit

struct LocationSearchResultsCreator {
    
    func getController() -> LocationSearchResultsController {
//        let userDefaults = UserDefaults.standard
//        let jsonHelper = SerializeHelper.shared
//        let repository = SavedLocationRepositoryImpl(userDefaults: userDefaults, jsonHelper: jsonHelper)
        let controller = LocationSearchResultsController()
        return controller
    }
}

protocol LocationSearchResultsDelegate: class {
    func didLocationSearch(latitude: Double, longitude: Double, locationName: String)
}

final class LocationSearchResultsController: UITableViewController {
        
    private var searchResults = [MKLocalSearchCompletion]()
    private var searchCompleter = MKLocalSearchCompleter()
        
    var delegate: LocationSearchResultsDelegate?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        searchCompleter.delegate = self
        searchCompleter.pointOfInterestFilter = .none
    }
    
}

extension LocationSearchResultsController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let searchResult = searchResults[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.subtitle
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchResults[indexPath.row].title
        
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard let coordinates = response?.mapItems[0].placemark.coordinate else { return }
            guard let name = response?.mapItems[0].name else { return }
            
            self.delegate?.didLocationSearch(latitude: coordinates.latitude, longitude: coordinates.longitude, locationName: name)
        }
        
        self.tableView.deselectRow(at: indexPath, animated: true)
        dismiss(animated: true, completion: nil)
    }
}

extension LocationSearchResultsController: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results.filter { result in
            if result.title.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil { return false }
            if result.subtitle.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil { return false }
            
            return true
        }
        
        self.tableView.reloadData()
    }
}

extension LocationSearchResultsController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCompleter.queryFragment = searchText
    }
}
