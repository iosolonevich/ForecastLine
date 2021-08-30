//
//  LocationListController.swift
//  ForecastLine
//
//  Created by alex on 11.07.2021.
//

import UIKit

final class LocationListController: BaseViewController {
    
    private var locationListTableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    private let viewModel: LocationListViewModel
    private let cellManager: LocationListCellManager

    init(viewModel: LocationListViewModel, cellManager: LocationListCellManager) {
        self.viewModel = viewModel
        self.cellManager = cellManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.saveSampleLocations()
        
        setupTableView()
        setupNavigationBar()
        setupViewModelDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //        spinner?
        viewModel.getSavedLocations()
    }
    
    @objc private func handleAddLocationButton(_ sender: UIBarButtonItem) {
        
        let locationSearchController = LocationSearchCreator().getController()
        
        locationSearchController.isDismissed = { [weak self] in
            self?.viewModel.getSavedLocations()
            self?.locationListTableView.reloadData()
        }
        
        let navController = UINavigationController(rootViewController: locationSearchController)
        self.present(navController, animated: true, completion: nil)
//        navigationController?.pushViewController(locationSearchController, animated: true)
    }
    
    @objc private func handleSettingsButton(_ sender: UIBarButtonItem) {
        
        let settingsController = SettingsCreator().getController()        
        let navController = UINavigationController(rootViewController: settingsController)
        self.present(navController, animated: true, completion: nil)
    }
}

extension LocationListController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.locationWeathers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let locationWeathers = viewModel.locationWeathers
        return cellManager.buildCell(tableView: tableView, indexPath: indexPath, locationWeathers: locationWeathers)
    }
}

extension LocationListController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = viewModel.locationWeathers[indexPath.row]
        navigateToLocationForecast(location: location)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}

extension LocationListController: LocationListViewModelDelegate {
    
    func didUpdateFavouriteLocationWeathers() {
        //spinner
        locationListTableView.reloadData()
    }
    
    func didFailWithError(error: Error) {
        //presentAlert
    }
}

private extension LocationListController {
    
    private func setupTableView() {
        locationListTableView.register(cellType: LocationListTableViewCell.self)
        locationListTableView.delegate = self
        locationListTableView.dataSource = self
        
        view.addSubview(locationListTableView, anchors: [ .top(view.topAnchor), .leading(view.leadingAnchor), .trailing(view.trailingAnchor), .bottom(view.bottomAnchor) ])
    }
    
    private func setupNavigationBar() {
        title = "ForecastLine"
        //navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.magnifyingglass"), style: .done, target: self, action: #selector(handleAddLocationButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .done, target: self, action: #selector(handleSettingsButton))
    }
    
    private func setupViewModelDelegate() {
        viewModel.delegate = self
    }
    
    private func navigateToLocationForecast(location: LocationWeather) {
        let locationForecastController = LocationForecastCreator().getController(with: location)
        navigationController?.pushViewController(locationForecastController, animated: true)
    }
}
