//
//  UIView+Ext.swift
//
//  Created by alex on 12.07.2021.
//

import UIKit

extension UIView {
    
    func addSubview(_ subview: UIView, anchors: [LayoutAnchor]) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        subview.activate(anchors: anchors)
    }
    
    private func activate(anchors: [LayoutAnchor]) {
        
        let constraints: [NSLayoutConstraint] = anchors.map {
            switch $0 {
            case let .top(topAnchor, constant):
                return self.topAnchor.constraint(equalTo: topAnchor, constant: constant)
            case let .leading(leadingAnchor, constant):
                return self.leadingAnchor.constraint(equalTo: leadingAnchor, constant: constant)
            
            case let .trailing(trailingAnchor, constant):
                return self.trailingAnchor.constraint(equalTo: trailingAnchor, constant: constant)
            case let .bottom(bottomAnchor, constant):
                return self.bottomAnchor.constraint(equalTo: bottomAnchor, constant: constant)
            
            case .heightConstant(let height):
                return self.heightAnchor.constraint(equalToConstant: height)
            case .widthConstant(let width):
                return self.widthAnchor.constraint(equalToConstant: width)
            case let .height(heightAnchor, multiplier, constant):
                return self.heightAnchor.constraint(equalTo: heightAnchor, multiplier: multiplier, constant: constant)
            case let .width(widthAnchor, multiplier, constant):
                return self.widthAnchor.constraint(equalTo: widthAnchor, multiplier: multiplier, constant: constant)
                
            case .centerX(let centerXAnchor):
                return self.centerXAnchor.constraint(equalTo: centerXAnchor)
            case .centerY(let centerYAnchor):
                return self.centerYAnchor.constraint(equalTo: centerYAnchor)
            }
            
        }
        NSLayoutConstraint.activate(constraints)
    }
}

enum LayoutAnchor {
    case top(_ topAnchor: NSLayoutYAxisAnchor, _ constant: CGFloat = 0)
    case leading(_ leadingAnchor: NSLayoutXAxisAnchor, _ constant: CGFloat = 0)
    case trailing(_ trailingAnchor: NSLayoutXAxisAnchor, _ constant: CGFloat = 0)
    case bottom(_ bottomAnchor: NSLayoutYAxisAnchor, _ constant: CGFloat = 0)
    
    case heightConstant(_ height: CGFloat)
    case widthConstant(_ width: CGFloat)
    
    case height(_ heightAnchor: NSLayoutDimension, _ multiplier: CGFloat = 1, _ constant: CGFloat = 0)
    case width(_ widthAnchor: NSLayoutDimension, _ multiplier: CGFloat = 1, _ constant: CGFloat = 0)
    
    case centerX(_ centerXAnchor: NSLayoutXAxisAnchor)
    case centerY(_ centerYAnchor: NSLayoutYAxisAnchor)
    
    
}
