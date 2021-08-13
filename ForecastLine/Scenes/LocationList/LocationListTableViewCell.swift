//
//  LocationListTableViewCell.swift
//  ForecastLine
//
//  Created by alex on 11.07.2021.
//

import UIKit

class LocationListTableViewCell: UITableViewCell {

    private var locationStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
//        stack.backgroundColor = .green
        return stack
    }()
    
    private var labelsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
//        stack.backgroundColor = .blue
        return stack
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private var tempLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private var weatherSymbol: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var hourlyLineChart: LineChartView = {
        let chart = LineChartView()
//        chart.backgroundColor = .systemPink
        return chart
    }()
    
    private var dailyLineChart: LineChartView = {
        let chart = LineChartView()
//        chart.backgroundColor = .systemPink
        return chart
    }()
    
    func setup(with locationForecastDisplayable: LocationWeatherDisplayable) {
        
        self.contentView.addSubview(locationStack, anchors: [
                                        .top(self.contentView.topAnchor, 10),
                                        .bottom(self.contentView.bottomAnchor, -10),
                                        .leading(self.contentView.leadingAnchor),
                                        .trailing(self.contentView.trailingAnchor)])
        
        locationStack.addSubview(labelsStack, anchors: [
                                    .top(locationStack.topAnchor),
                                    .leading(locationStack.leadingAnchor),
                                    .trailing(locationStack.trailingAnchor)
//                                    .heightConstant(40)
        ])
        
        locationStack.addSubview(dailyLineChart, anchors: [
                                    .top(labelsStack.bottomAnchor, 5),
                                    .leading(locationStack.leadingAnchor, 5),
                                    .trailing(locationStack.trailingAnchor, -5),
                                    .bottom(locationStack.bottomAnchor, -5)])
        
        labelsStack.addSubview(nameLabel, anchors: [
                                .top(labelsStack.topAnchor, 10),
                                .leading(labelsStack.leadingAnchor, 10),
                                .bottom(labelsStack.bottomAnchor, -10)])
        
        labelsStack.addSubview(tempLabel, anchors: [
                                .top(labelsStack.topAnchor, 10),
                                .trailing(labelsStack.trailingAnchor, -50),
                                .bottom(labelsStack.bottomAnchor, -10)])
        
        labelsStack.addSubview(weatherSymbol, anchors: [
                                .top(labelsStack.topAnchor, 10),
                                .leading(tempLabel.trailingAnchor, 5),
                                .trailing(labelsStack.trailingAnchor, -10),
                                .bottom(labelsStack.bottomAnchor, -10)])
        
        nameLabel.text = locationForecastDisplayable.name
        tempLabel.text = locationForecastDisplayable.temp
        weatherSymbol.image = UIImage(systemName: locationForecastDisplayable.symbol.icon)
        dailyLineChart.dataEntries = locationForecastDisplayable.daily.map {
            PointEntry(value: $0.tempValue, axisLabel: $0.day, pointLabel: $0.temp, symbol: $0.symbol) }
    }
}
