//
//  TimeseriesResponse.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 16/11/2024.
//

import Foundation

// Root model for historical rates response
struct TimeseriesResponse: Codable {
    let success: Bool
    let terms: String
    let privacy: String
    let base: String
    let startDate: String
    let endDate: String
    let rates: [String: [String: Double]] // Dictionary with dates as keys and another dictionary of rates as values

    // Map JSON keys to Swift properties
    enum CodingKeys: String, CodingKey {
        case success, terms, privacy, base
        case startDate = "start_date"
        case endDate = "end_date"
        case rates
    }
    
    func getExchangeRates(for currency: String) -> [ExchangeRateModel] {
        let dateFormatter = ISO8601DateFormatter()
        var exchangeRates: [ExchangeRateModel] = []

        for (dateString, rates) in rates {
            if let rate = rates[currency],
               let date = dateFormatter.date(from: dateString) {
                exchangeRates.append(ExchangeRateModel(date: date, rate: rate))
            }
        }

        return exchangeRates.sorted { $0.date < $1.date }
    }
    
    static func decodeJson(renderedJson: String) {
        let jsonData = renderedJson.data(using: .utf8)!

        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(TimeseriesResponse.self, from: jsonData)

            // Access data
            print("Success: \(response.success)")
            print("Base Currency: \(response.base)")
            print("Start Date: \(response.startDate)")
            print("End Date: \(response.endDate)")

            // Iterate over rates
            for (date, rates) in response.rates {
                print("Date: \(date)")
                for (currency, rate) in rates {
                    print("\(currency): \(rate)")
                }
            }
        } catch {
            print("Error decoding JSON: \(error)")
        }

    }
}
