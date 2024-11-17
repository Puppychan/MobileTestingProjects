//
//  HistoricalConversionResponse.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 16/11/2024.
//

import Foundation


// Root model for latest rates response
struct HistoricalConversionResponse: Codable {
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
            let response = try decoder.decode(HistoricalConversionResponse.self, from: jsonData)

            // Access data
            print("Success: \(response.success)")
            print("Base Currency: \(response.base)")
            print("Date: \(response.date)")
            print("Rates:")
            for (currency, rate) in response.rates {
                print("\(currency): \(rate)")
            }
        } catch {
            print("Error decoding JSON: \(error)")
        }

    }
}
