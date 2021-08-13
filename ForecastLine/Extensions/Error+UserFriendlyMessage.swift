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

struct APIError: Error {
    let statusCode: Int
    let data: Data?
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

extension Error {
    
    var userFriendlyMessage: String {
        if let appError = self as? AppError {
            return appError.message
        } else if self is APIError {
            return "error api"
        } else if self is InvalidURLError {
            return "error invalid url"
        } else if self is MissingAPIResponse {
            return "error missing api response"
        } else if self is MissingAPIData {
            return "error missing api data"
        } else if self is SerializerError {
            return "error serializer"
        } else if self is UserDefaultsError {
            return "error userDefaults"
        } else {
            return "error unknown"
        }
        
    }
    
    var developerFriendlyMessage: String {
        if let apiError = self as? APIError {
            print("API responded with statusCode: \(apiError.statusCode), data: \(String(describing: apiError.data))")
            return "error api"
        } else {
            print(String(describing: self))
            return "error unknown"
        }
    }
}
