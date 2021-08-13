//
//  PrivacyViewModel.swift
//  ForecastLine
//
//  Created by alex on 24.07.2021.
//

import Foundation

final class PrivacyViewModel {
    
    
}

extension PrivacyViewModel {
    
    func getPrivacyContent() -> NSAttributedString? {
        
        if let url = Bundle.main.url(forResource: "privacyandterms", withExtension: "rtf") {
            let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.rtf]
            let rtfString = try? NSMutableAttributedString(url: url, options: options, documentAttributes: nil)
            
            return rtfString
        }
        
        return nil
    }
}
