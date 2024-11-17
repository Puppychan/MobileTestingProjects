//
//  CurrenciesResponse.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 16/11/2024.
//

import Foundation

// Root model containing currency codes as keys and their details as values
struct CurrenciesResponse: Codable {
    let currencies: [String: CurrencyDetailModel]

    // Custom initializer to decode flat JSON
    init(from decoder: Decoder) throws {
        // Decode the flat JSON directly into the `currencies` dictionary
        let container = try decoder.singleValueContainer()
        currencies = try container.decode([String: CurrencyDetailModel].self)
    }


    enum CodingKeys: CodingKey { } // No keys since the JSON is flat
    static func decodeJson(renderedJson: String) {
        let jsonData = renderedJson.data(using: .utf8)!

        do {
            let decoder = JSONDecoder()
            let currencyDetails = try decoder.decode(CurrenciesResponse.self, from: jsonData)

            // Access currency details
            print(currencyDetails.currencies["AFN"]?.name ?? "No data") // Output: Afghan Afghani
        } catch {
            print("Error decoding JSON: \(error)")
        }

    }
}

