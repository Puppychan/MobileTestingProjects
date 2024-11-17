//
//  NetworkEnum.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 15/11/2024.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case noData
    case decodingError
    case custom(message: String)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .invalidResponse:
            return "Received an invalid response from the server."
        case .noData:
            return "No data was received from the server."
        case .decodingError:
            return "Failed to decode the response."
        case .custom(let message):
            return message
        }
    }
}
