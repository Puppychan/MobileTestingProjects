//
//  NetworkErrorEnum.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 16/11/2024.
//

import Foundation
// Enum to define network-related errors
enum NetworkErrorEnum: Error, LocalizedError {
    case invalidURL
    case noInternetConnection
    case noData
    case decodingError
    case custom(message: String) // Add a custom error case

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .noInternetConnection:
            return "No internet connection. Please check your network settings."
        case .noData:
            return "No data received from the server."
        case .decodingError:
            return "Failed to decode the data."
        case .custom(let message):
            return message // Return the custom message
        }
    }
}
