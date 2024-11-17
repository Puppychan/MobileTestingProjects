//
//  ExchangeRateResponse.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 15/11/2024.
//

import Foundation
struct ExchangeRateResponse: Decodable {
    let conversionRate: Double

    enum CodingKeys: String, CodingKey {
        case conversionRate = "conversion_rate"
    }
}
