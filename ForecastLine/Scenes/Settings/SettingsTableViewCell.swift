//
//  SettingsTableViewCell.swift
//  ForecastLine
//
//  Created by alex on 23.07.2021.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    var sectionType: SectionType? {
        didSet {
            guard let sectionType = sectionType else { return }
            textLabel?.text = sectionType.description
            switchControl.isHidden = !sectionType.containsSwitch
            accessoryType = sectionType.containsDisclosureIndicator ? .disclosureIndicator : .none
        }
    }
    
    lazy var switchControl: UISwitch = {
        let switchControl = UISwitch()
        switchControl.isOn = true
        switchControl.addTarget(self, action: #selector(handleSwitchAction), for: .valueChanged)
        return switchControl
    }()
    
    @objc func handleSwitchAction(sender: UISwitch) {
        if sender.isOn {
            print("turned on")
        } else {
            print("turned off")
        }
    }
    
    func setup() {
        
        addSubview(switchControl, anchors: [ .centerY(centerYAnchor), .top(topAnchor), .trailing(trailingAnchor, -14), .bottom(bottomAnchor) ])
    }
}
