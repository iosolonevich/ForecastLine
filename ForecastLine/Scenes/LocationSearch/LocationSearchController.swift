//
//  LocationSearchController.swift
//  ForecastLine
//
//  Created by alex on 26.07.2021.
//

import UIKit

class LocationSearchController: BaseViewController {

    private var locationsTableView: UITableView = {
        let tableView = UITableView()
        tableView.alwaysBounceVertical = false
        tableView.backgroundColor = UIColor.white
        tableView.register(cellType: UITableViewCell.self)
        return tableView
    }()
    
    private let viewModel: LocationSearchViewModel
    private let cellManager: LocationSearchCellManager
    private let searchController: UISearchController
    
    var isDismissed: (() -> Void)?
    
    init(viewModel: LocationSearchViewModel, cellManager: LocationSearchCellManager, searchController: UISearchController) {
        self.viewModel = viewModel
        self.cellManager = cellManager
        self.searchController = searchController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getSavedLocations()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.isDismissed?()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchController()
        
        title = "Locations"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        locationsTableView.dataSource = self
        
        view.addSubview(locationsTableView, anchors: [ .top(view.topAnchor), .leading(view.leadingAnchor), .trailing(view.trailingAnchor), .bottom(view.bottomAnchor) ])
        
    }

}

extension LocationSearchController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellManager.buildCell(tableView: tableView, indexPath: indexPath, locations: viewModel.locations)
    }
}

extension LocationSearchController: LocationSearchResultsDelegate {
    
    func didLocationSearch(latitude: Double, longitude: Double, locationName: String) {
        
        //save locations using viewmodel
        let location = Location(id: "", name: locationName, latitude: latitude, longitude: longitude)
        viewModel.saveLocation(location: location)
        
        self.reset()
    }
}

private extension LocationSearchController {
    
    func setupSearchController() {
        
        let searchResultsController = searchController.searchResultsController as? LocationSearchResultsController
        
        searchController.searchBar.delegate = searchResultsController
        
        searchResultsController?.delegate = self
        
        searchController.searchBar.returnKeyType = .search
        searchController.searchBar.searchTextField.placeholder = NSLocalizedString("Enter a location", comment: "")
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    func reset() {
        self.searchController.searchBar.text = ""
        self.locationsTableView.reloadData()
    }
}
