//
//  Error+UserFriendlyMessage.swift
//  ForecastLine
//
//  Created by alex on 11.07.2021.
//

import Foundation

struct AppError: Error {
    let message: String
}

struct InvalidURLError: Error {}

struct MissingAPIResponse: Error {}

struct MissingAPIData: Error {}

enum UserDefaultsError: Error {
    case readUserDefaults
    case writeUserDefaults
}

enum SerializerError: Error {
    case jsonDecodingError
    case jsonEncodingError
}
