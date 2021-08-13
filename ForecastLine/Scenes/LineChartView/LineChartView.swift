//
//  LineChartView.swift
//  ForecastLine
//
//  Created by alex on 13.08.2021.
//

import UIKit

class LineChartView: UIView {

    // gap between each point
    let lineGap: CGFloat = 40
    // preserved space at the top of the chart
    let topSpace: CGFloat = 50.0
    // preserved space at the bottom of the chart to show labels along the Y axis
    let bottomSpace: CGFloat = 50.0
    
    var dataEntries: [PointEntry]? {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    // contains the main line
    private static let dataLayerName = "linelayer"
    private let dataLayer: CALayer = {
        let layer = CALayer()
        layer.name = dataLayerName
        return layer
    }()
    
    
    // contains data layer
    private let mainLayer: CALayer = CALayer()
    // contains mainLayer and labels for each data entry
    private let scrollView: UIScrollView = UIScrollView()
    
    // calculated from dataEntries
    private var dataPoints: [CGPoint]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    convenience init() {
        self.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        mainLayer.addSublayer(dataLayer)
        scrollView.layer.addSublayer(mainLayer)
        
        self.addSubview(scrollView)
    }
    
    override func layoutSubviews() {
        scrollView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        guard let dataEntries = dataEntries else { return }
        scrollView.contentSize = CGSize(width: CGFloat(dataEntries.count) * lineGap, height: self.frame.size.height)
        mainLayer.frame = CGRect(x: 0, y: 0, width: CGFloat(dataEntries.count) * lineGap, height: self.frame.size.height)
        dataLayer.frame = CGRect(x: 0, y: topSpace, width: mainLayer.frame.width, height: mainLayer.frame.height - topSpace - bottomSpace)
        
        dataPoints = convertDataEntriesToPoints(entries: dataEntries)
        

        clean()
        drawChart()
        drawBottomLabels()
        drawTopLabels()
        drawDots()
    }
    
    private func convertDataEntriesToPoints(entries: [PointEntry]) -> [CGPoint] {
        guard let max = entries.max()?.value, let min = entries.min()?.value else { return [] }
        
        var result: [CGPoint] = []
        let minMaxRange: CGFloat = CGFloat(max - min)
        
        for i in 0..<entries.count {
            let height = dataLayer.frame.height * (1 - ((CGFloat(entries[i].value) - CGFloat(min)) / minMaxRange))
            let point = CGPoint(x: CGFloat(i) * lineGap + 40, y: height)
            result.append(point)
        }
        return result
    }
    
    private func getDataEntryFromPoint(point: CGPoint) -> PointEntry? {
        let i =  Int((point.x - 40) / lineGap)
        
        if let dataEntry = dataEntries?[i] { return dataEntry } else { return nil}
    }
    
    private func drawChart() {
        guard let dataPoints = dataPoints, dataPoints.count > 0 else { return }
        
        if let path = CurveAlgorithm.shared.createCurvedPath(dataPoints) {
            let lineLayer = CAShapeLayer()
            lineLayer.path = path.cgPath
            lineLayer.strokeColor = UIColor.darkGray.cgColor
            lineLayer.fillColor = UIColor.clear.cgColor
            dataLayer.addSublayer(lineLayer)
        }
    }
    
    private func drawBottomLabels() {
        guard let dataEntries = dataEntries, dataEntries.count > 0 else { return }
        for i in 0..<dataEntries.count {
            let textLayer = CATextLayer()
            textLayer.frame = CGRect(x: lineGap*CGFloat(i) - lineGap/2 + 40, y: mainLayer.frame.size
                                        .height - bottomSpace/2 - 8, width: lineGap, height: 16)
            textLayer.foregroundColor = #colorLiteral(red: 0.5019607843, green: 0.6784313725, blue: 0.8078431373, alpha: 1).cgColor
            textLayer.backgroundColor = UIColor.clear.cgColor
            textLayer.alignmentMode = .center
            textLayer.contentsScale = UIScreen.main.scale
            textLayer.font = CTFontCreateWithName(UIFont.systemFont(ofSize: 0).fontName as CFString, 0, nil)
            textLayer.fontSize = 11
            textLayer.string = dataEntries[i].axisLabel
            mainLayer.addSublayer(textLayer)
        }
    }
    
    let outerRadius: CGFloat = 13
    private func drawTopLabels() {
        guard let dataPoints = dataPoints, dataPoints.count > 0 else { return }
        for dataPoint in dataPoints {
            let textLayer = CATextLayer()
            let xValue = dataPoint.x - outerRadius/2
            let yValue = (dataPoint.y + lineGap) - (outerRadius * 2)
            textLayer.frame = CGRect(origin: CGPoint(x: xValue - 3, y: yValue + 12), size: CGSize(width: 20, height: 20))
            textLayer.foregroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1).cgColor
            textLayer.backgroundColor = UIColor.clear.cgColor
            textLayer.alignmentMode = CATextLayerAlignmentMode.center
            textLayer.contentsScale = UIScreen.main.scale
            textLayer.font = CTFontCreateWithName(UIFont.systemFont(ofSize: 0).fontName as CFString, 0, nil)
            textLayer.fontSize = 11
            textLayer.string = getDataEntryFromPoint(point: dataPoint)?.pointLabel
            mainLayer.addSublayer(textLayer)
        }
    }
    
    private func clean() {
        mainLayer.sublayers?.forEach({
            if $0.name != LineChartView.dataLayerName {
                $0.removeFromSuperlayer()
            }
        })
        dataLayer.sublayers?.forEach({ $0.removeFromSuperlayer() })
    }
    
    private func drawDots() {
//        var dotLayers: [CALayer] = []
        guard let dataPoints = dataPoints else { return }
        
        for dataPoint in dataPoints {
            let xValue = dataPoint.x - outerRadius/2
            let yValue = (dataPoint.y + lineGap) - (outerRadius * 2)
            let dotLayer = CALayer()
            //                dotLayer.dotInnerColor = UIColor.orange
            //dotLayer.innerRadius = innerRadius
            //                dotLayer.backgroundColor = UIColor.clear.cgColor
            //                dotLayer.cornerRadius = outerRadius / 2
            
            //                dotLayer.backgroundColor = UIColor.orange.cgColor
            
            dotLayer.contentsGravity = .resizeAspect
            dotLayer.isGeometryFlipped = true
            
            
//            guard let icon = getDataEntryFromPoint(point: dataPoint)?.icon else { return }
//            let image = UIImage(named: icon)//?.withBackground(color: UIColor.white)
            
            guard let symbol = getDataEntryFromPoint(point: dataPoint)?.symbol else { return }
            let image = UIImage(systemName: symbol.icon)?.withBackground(color: .white)
            
            
            //                dotLayer.frame = CGRect(x: xValue, y: yValue, width: outerRadius+5, height: outerRadius+5)
            dotLayer.frame = CGRect(origin: CGPoint(x: xValue , y: yValue + 23), size: CGSize(width: 25, height: 25))
            dotLayer.contents = image?.cgImage
//            dotLayers.append(dotLayer)
            //                dotLayer.zPosition = CGFloat(0)
            //                mainLayer.insertSublayer(dotLayer, above: mainLayer)
            mainLayer.addSublayer(dotLayer)
            
            
//            let anim = CABasicAnimation(keyPath: "opacity")
//            anim.duration = 1.0
//            anim.fromValue = 0
//            anim.toValue = 1
//            dotLayer.add(anim, forKey: "opacity")
        
            
        }
    }
}
