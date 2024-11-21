//
//  TimeseriesResponse.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 16/11/2024.
//

import Foundation

// Root model for historical rates response
struct TimeseriesResponse: Codable, Equatable {
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
    
    static func == (lhs: TimeseriesResponse, rhs: TimeseriesResponse) -> Bool {
        return lhs.success == rhs.success &&
        lhs.terms == rhs.terms &&
        lhs.privacy == rhs.privacy &&
        lhs.base == rhs.base &&
        lhs.startDate == rhs.startDate &&
        lhs.endDate == rhs.endDate &&
        lhs.rates == rhs.rates
    }
    
    
    func getExchangeRates(for currency: String) -> [ExchangeRateModel] {
        var exchangeRates: [ExchangeRateModel] = []
        
        for (dateString, rateDictionary) in rates {
            if let rate = rateDictionary[currency],
               let date = fromTimestamptzToDate(dateString) {
                
                exchangeRates.append(ExchangeRateModel(date: date, rate: rate))
            }
        }
        
        print("Response inside getExchangeRates \(exchangeRates)")
        
        return exchangeRates.sorted { $0.date < $1.date }
    }
    
    /// Converts the `TimeseriesResponse` into an array of `CurrencyRateModel` objects.
    /// - Returns: An array of `CurrencyRateModel` containing all rates for all dates and currencies.
    func toCurrencyRateModels() -> [CurrencyRateModel] {
        var models: [CurrencyRateModel] = []
        
        for (dateString, rateDictionary) in rates {
            if let date = fromTimestamptzToDate(dateString) {
                for (currencyCode, rate) in rateDictionary {
                    let model = CurrencyRateModel(date: date, currencyCode: currencyCode, rate: rate)
                    models.append(model)
                }
            }
        }
        
        return models.sorted { $0.date < $1.date } // Sort by date
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
