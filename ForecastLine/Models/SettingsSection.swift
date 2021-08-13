//
//  SettingsSection.swift
//  ForecastLine
//
//  Created by alex on 22.07.2021.
//

import Foundation

protocol SectionType: CustomStringConvertible {
    var containsSwitch: Bool { get }
    var containsDisclosureIndicator: Bool { get }
}

enum SettingsSection: Int, CaseIterable, CustomStringConvertible {
    
    case Appearance
    case Other
    
    var description: String {
        switch self {
        case .Appearance: return "Appearance"
        case .Other: return "Other"
        }
    }
}

enum AppearanceOptions: Int, CaseIterable, SectionType {
    
    case units
    case theme
    
    var containsSwitch: Bool {
        switch self {
        case .units: return false
        case .theme: return true
        }
    }
    
    var containsDisclosureIndicator: Bool {
        switch self {
        case .units: return false
        case .theme: return false
        }
    }
    
    var description: String {
        switch self {
        case .units: return "Units"
        case .theme: return "Dark mode"
        }
    }
}

enum OtherOptions: Int, CaseIterable, SectionType {
    
    case emailSupport
    case rateThisApp
    case privacy
    case about
    
    var containsSwitch: Bool {
        return false
    }
    
    var containsDisclosureIndicator: Bool {
        switch self {
        case .emailSupport: return false
        case .rateThisApp: return false
        case .privacy: return true
        case .about: return false
        }
    }
    
    var description: String {
        switch self {
        case .emailSupport: return "Email Suppport"
        case .rateThisApp: return "Rate This App"
        case .privacy: return "Privacy Policy"
        case .about: return "About The App"
        }
    }
}
