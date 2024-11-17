//
//  CurrencyDetailModel.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 16/11/2024.
//

import Foundation
// Model for each currency detail
struct CurrencyDetailModel: Codable {
    let code: String
    let name: String
    let decimalDigits: Int
    let namePlural: String
    let rounding: Int
    let symbol: String
    let symbolNative: String

    // Map JSON keys to Swift property names
    enum CodingKeys: String, CodingKey {
        case code
        case name
        case decimalDigits = "decimal_digits"
        case namePlural = "name_plural"
        case rounding
        case symbol
        case symbolNative = "symbol_native"
    }
    
    // Default instances for From and To currencies
    static let defaultFromCurrency = CurrencyDetailModel(
        code: "USD",
        name: "US Dollar",
        decimalDigits: 2,
        namePlural: "US dollars",
        rounding: 0,
        symbol: "$",
        symbolNative: "$"
    )

    static let defaultToCurrency = CurrencyDetailModel(
        code: "VND",
        name: "Vietnamese Dong",
        decimalDigits: 0,
        namePlural: "Vietnamese dong",
        rounding: 0,
        symbol: "₫",
        symbolNative: "₫"
    )
}
