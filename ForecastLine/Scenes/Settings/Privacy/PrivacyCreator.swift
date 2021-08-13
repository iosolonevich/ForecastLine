//
//  PrivacyCreator.swift
//  ForecastLine
//
//  Created by alex on 24.07.2021.
//

import Foundation

struct PrivacyCreator {
    
    func getController() -> PrivacyController {
        
        let viewModel = PrivacyViewModel()
        let controller = PrivacyController(viewModel: viewModel)
        return controller
    }
}
