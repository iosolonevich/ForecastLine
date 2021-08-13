//
//  LocationListTableViewCell.swift
//  ForecastLine
//
//  Created by alex on 11.07.2021.
//

import UIKit

class LocationListTableViewCell: UITableViewCell {

    private var nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        return label
    }()
    
    private var tempLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemPink
        return label
    }()
    
    private var weatherSymbol: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .brown
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    func setup(with locationForecastDisplayable: LocationWeatherDisplayable) {
        self.contentView.addSubview(nameLabel, anchors: [
                                        .top(self.contentView.topAnchor, 10),
                                        .leading(self.contentView.leadingAnchor, 10),
                                        .bottom(self.contentView.bottomAnchor, -10)
                                    ])
        self.contentView.addSubview(tempLabel, anchors: [
                                        .top(self.contentView.topAnchor, 10),
                                        .trailing(self.contentView.trailingAnchor, -50),
                                        .bottom(self.contentView.bottomAnchor, -10) ])
        self.contentView.addSubview(weatherSymbol, anchors: [
                                        .top(self.contentView.topAnchor, 10),
                                        .leading(self.tempLabel.trailingAnchor, 5),
                                        .trailing(self.contentView.trailingAnchor, -10),
                                        .bottom(self.contentView.bottomAnchor, -10) ])
        
        nameLabel.text = locationForecastDisplayable.name
        tempLabel.text = locationForecastDisplayable.temp
        weatherSymbol.image = UIImage(systemName: locationForecastDisplayable.symbol.icon)
    }

}
