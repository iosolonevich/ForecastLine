//
//  UITableView+Register+Dequeue.swift
//  ForecastLine
//
//  Created by alex on 11.07.2021.
//

import UIKit

public extension UITableView {
    
    func register<T: UITableViewCell>(cellType: T.Type) {
        let className = cellType.className
        register(cellType, forCellReuseIdentifier: className)
    }
    
    func register<T: UITableViewCell>(cellTypes: [T.Type]) {
        cellTypes.forEach { register(cellType: $0) }
    }
     
    func dequeue<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as? T else {
            fatalError("Failed to dequeue table view cell!")
        }
        
        return cell
    }
    
    func reloadData(with animation: UITableView.RowAnimation) {
        reloadSections(IndexSet(integersIn: 0..<numberOfSections), with: animation)
    }
}
