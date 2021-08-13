//
//  UIImage+WithBackgroundColor.swift
//  ForecastLine
//
//  Created by alex on 13.08.2021.
//

import UIKit

extension UIImage {
    
    func withBackground(color: UIColor) -> UIImage? {
        var image: UIImage?
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let imageRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(imageRect)
            draw(in: imageRect, blendMode: .normal, alpha: 1.0)
            image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
        return nil
    }
}
