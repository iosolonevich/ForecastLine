//
//  SettingsViewModel.swift
//  ForecastLine
//
//  Created by alex on 19.07.2021.
//

import Foundation

protocol SettingsViewModelDelegate {
    
}

final class SettingsViewModel {
    
    var settingsSections = SettingsSection.allCases
}

extension SettingsViewModel {
    
    func getNumberOfRows(section: Int) -> Int {
        
        let settingsSection = self.settingsSections[section]
        
        switch settingsSection {
        case .Appearance: return AppearanceOptions.allCases.count
        case .Other: return OtherOptions.allCases.count
        }
    }
    
    func getSectionType(indexPath: IndexPath) -> SectionType? {
        
        let section = SettingsSection(rawValue: indexPath.section)
        switch section {
        case .Appearance:
            if let appearance = AppearanceOptions(rawValue: indexPath.row) {
                return appearance
            }
            
        case .Other:
            if let other = OtherOptions(rawValue: indexPath.row) {
                return other
            }
        
        default: fatalError("Error when getting Settings section")
        }
        
        return nil
    }
}
