//
//  LocationForecastController.swift
//  ForecastLine
//
//  Created by alex on 24.07.2021.
//

import UIKit

protocol LocationForecastPresentable {
    func displayLocationDetails(_ locationDetails: LocationForecastDisplayable)
    func displayLocationForecast(hourlyForecast: [LocationHourlyForecastListDisplayable],
                            dailyForecast: [LocationDailyForecastListDisplayable])
}

final class LocationForecastController: BaseViewController {
    
    private var locationLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private var temperatureLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private var forecastTableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    private let viewModel: LocationForecastViewModel
    private let cellManager: LocationForecastCellManager
    
    init(viewModel: LocationForecastViewModel, cellManager: LocationForecastCellManager) {
        self.cellManager = cellManager
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let locationDetailsDisplayable = viewModel.getLocationDetails()
        locationLabel.text = locationDetailsDisplayable.name
        temperatureLabel.text = locationDetailsDisplayable.temp
        
        viewModel.getForecastsDisplayable()
        
        if let hourlyForecast = viewModel.forecastDisplayable?.hourlyForecastDisplayable,
           let dailyForecast = viewModel.forecastDisplayable?.dailyForecastDisplayable {
            cellManager.setup(with: hourlyForecast, dailyForecast)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupLocationDetailViews()
        setupTableView()
    }
}

extension LocationForecastController: LocationForecastPresentable {
    func displayLocationDetails(_ locationDetails: LocationForecastDisplayable) {
        locationLabel.text = locationDetails.name
        temperatureLabel.text = locationDetails.temp
        
    }
    
    func displayLocationForecast(hourlyForecast: [LocationHourlyForecastListDisplayable], dailyForecast: [LocationDailyForecastListDisplayable]) {
        cellManager.setup(with: hourlyForecast, dailyForecast)
        forecastTableView.reloadData()
    }
}

private extension LocationForecastController {
    
    private func setupLocationDetailViews() {
        
        view.addSubview(locationLabel, anchors: [ .top(view.topAnchor, 10), .centerX(view.centerXAnchor), .heightConstant(30) ])
        
        view.addSubview(temperatureLabel, anchors: [ .top(locationLabel.bottomAnchor, 10), .centerX(view.centerXAnchor), .heightConstant(100) ])
    }
    
    private func setupTableView() {
        
        forecastTableView.register(cellType: LocationForecastTableViewCell.self)
        
        forecastTableView.dataSource = cellManager
        
        view.addSubview(forecastTableView, anchors: [ .top(temperatureLabel.bottomAnchor, 20), .leading(view.leadingAnchor), .trailing(view.trailingAnchor), .bottom(view.bottomAnchor) ])
    }
    
}
