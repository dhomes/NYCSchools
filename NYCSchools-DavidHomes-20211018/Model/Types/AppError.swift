//
//  AppError.swift
//  20211018-DavidHomes-NYCSchools
//
//  Created by dhomes on 10/18/21.
//

import Foundation

/// App Domain specific errors
enum AppError : LocalizedError {
    
    /// Request response could not be parsed
    case unparsableData
    
    /// Invalid URL for network request
    case invalidUrl
    
    var errorDescription : String? {
        switch self {
        case .unparsableData:
            return "Response data could not be parsed"
        case .invalidUrl:
            return "Invalid resource address"
        }
    }
}
