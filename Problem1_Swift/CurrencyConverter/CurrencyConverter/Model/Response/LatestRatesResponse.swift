//
//  LatestRatesResponse.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 16/11/2024.
//

import Foundation

// Root model for the API response
struct LatestRatesResponse: Codable {
    let success: Bool
    let terms: String
    let privacy: String
    let timestamp: Int
    let date: String
    let base: String
    let rates: [String: Double]
    

    static func decodeJson(renderedJson: String) {
        let jsonData = renderedJson.data(using: .utf8)!
        
        do {
            let decoder = JSONDecoder()
            let currencyResponse = try decoder.decode(LatestRatesResponse.self, from: jsonData)
            
            print("Base Currency: \(currencyResponse.base)")
            print("Rates: \(currencyResponse.rates)")
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
}
