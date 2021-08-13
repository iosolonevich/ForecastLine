//
//  File.swift
//  ForecastLine
//
//  Created by alex on 13.08.2021.
//

import UIKit

struct CurvedSegment {
    var controlPoint1: CGPoint
    var controlPoint2: CGPoint
}

class CurveAlgorithm {
    
    static let shared = CurveAlgorithm()
    
    private func controlPointsFrom(points: [CGPoint]) -> [CurvedSegment] {
        var result: [CurvedSegment] = []
        
        let delta: CGFloat = 0.3 // the value that helps to choose temporary control points
        
        // calculate temporary control points, these points make Bezier segments look straight and not curved at all
        for i in 1..<points.count {
            let A = points[i - 1]
            let B = points[i]
            let controlPoint1 = CGPoint(x: A.x + delta * (B.x - A.x), y: A.y + delta * (B.y - A.y))
            let controlPoint2 = CGPoint(x: B.x - delta*(B.x-A.x), y: B.y - delta*(B.y - A.y))
            let curvedSegment = CurvedSegment(controlPoint1: controlPoint1, controlPoint2: controlPoint2)
            result.append(curvedSegment)
        }
        
        // calculate final control points
        for i in 1..<points.count - 1 {
            // a temporary control point
            let M = result[i - 1].controlPoint2
            // a temporary control point
            let N = result[i].controlPoint1
            
            // central point
            let A = points[i]
            
            // reflection of M over the point A
            let MM = CGPoint(x: 2 * A.x - M.x, y: 2 * A.y - M.y)
            // reflectino of N over the point A
            let NN = CGPoint(x: 2 * A.x - N.x, y: 2 * A.y - N.y)
            
            result[i].controlPoint1 = CGPoint(x: (MM.x + N.x)/2, y: (MM.y + N.y)/2)
            result[i-1].controlPoint2 = CGPoint(x: (NN.x + M.x)/2, y: (NN.y + M.y)/2)
        }
        return result
    }
    
    // create a curved bezier path that connects all points in the dataset
    func createCurvedPath(_ dataPoints: [CGPoint]) -> UIBezierPath? {
        let path = UIBezierPath()
        path.move(to: dataPoints[0])
        
        var curveSegments: [CurvedSegment] = []
        curveSegments = controlPointsFrom(points: dataPoints)
        
        for i in 1..<dataPoints.count {
            path.addCurve(to: dataPoints[i], controlPoint1: curveSegments[i-1].controlPoint1, controlPoint2: curveSegments[i-1].controlPoint2)
        }
        return path
    }
}
