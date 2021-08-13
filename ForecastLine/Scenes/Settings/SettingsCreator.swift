//
//  File.swift
//  ForecastLine
//
//  Created by alex on 19.07.2021.
//

import Foundation

struct SettingsCreator {
    
    func getController() -> SettingsController {
        
        let viewModel = SettingsViewModel()
        let cellManager = SettingsCellManager()
        let controller = SettingsController(viewModel: viewModel, cellManager: cellManager)
        return controller
    }
}
