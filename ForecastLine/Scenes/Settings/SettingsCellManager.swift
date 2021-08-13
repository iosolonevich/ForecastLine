//
//  SettingsCellManager.swift
//  ForecastLine
//
//  Created by alex on 22.07.2021.
//

import UIKit

struct SettingsCellManager {
    
    func getViewForHeaderInSection(_ tableView: UITableView, sectionDescription description: String) -> UIView? {

        let view = UIView()
        let title = UILabel()
        title.text = description
        title.font = UIFont.boldSystemFont(ofSize: 20)
        title.textColor = .darkGray
        view.addSubview(title, anchors: [
                            .centerY(view.centerYAnchor),
                            .leading(view.leadingAnchor, 10) ])

        return view
    }
    
    func getHeightForHeaderInSection(_ tableView: UITableView) -> CGFloat {
        return 40
    }
    
    func buildCell(tableView: UITableView, indexPath: IndexPath, sectionType: SectionType?) -> UITableViewCell {
        
        let cell = tableView.dequeue(with: SettingsTableViewCell.self, for: indexPath)
        if let sectionType = sectionType {
            cell.sectionType = sectionType
        }
        
        return cell
    }
}
