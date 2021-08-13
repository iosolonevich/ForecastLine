//
//  LocationForecastTableViewCell.swift
//  ForecastLine
//
//  Created by alex on 25.07.2021.
//

import UIKit

class LocationForecastTableViewCell: UITableViewCell {

    private var dayLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private var minTemperatureLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private var maxTemperatureLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private weak var precipitationLabel: UILabel? = {
        let label = UILabel()
        
        return label
    }()
    
    private weak var weatherSymbol: UIImageView? = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    func setup(with locationDailyForecastListDisplayable: LocationDailyForecastListDisplayable) {
        dayLabel.text = locationDailyForecastListDisplayable.day
        minTemperatureLabel.text = locationDailyForecastListDisplayable.minTemp
        maxTemperatureLabel.text = locationDailyForecastListDisplayable.maxTemp
        precipitationLabel?.text = locationDailyForecastListDisplayable.precipitation
        weatherSymbol?.image = UIImage(systemName: locationDailyForecastListDisplayable.symbol.icon)
        
        addSubview(dayLabel, anchors: [ .centerY(centerYAnchor), .top(topAnchor), .leading(leadingAnchor), .bottom(bottomAnchor) ])
        addSubview(minTemperatureLabel, anchors: [ .centerY(centerYAnchor), .leading(dayLabel.trailingAnchor, 80), .top(topAnchor), .bottom(bottomAnchor) ])
        addSubview(maxTemperatureLabel, anchors: [ .centerY(centerYAnchor), .leading(minTemperatureLabel.trailingAnchor, 20), .top(topAnchor), .bottom(bottomAnchor) ])
    }
}
