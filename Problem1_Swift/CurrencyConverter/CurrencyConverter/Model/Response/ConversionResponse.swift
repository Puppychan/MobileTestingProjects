//
//  ConvertResponse.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 16/11/2024.
//

import Foundation

import Foundation

// Root model for the conversion response
struct ConversionResponse: Codable {
    let success: Bool
    let query: ConvertsionQuery
    let info: ConvertsionInfo
    let historical: Bool
    let date: String
    let timestamp: Int
    let result: Double
}

// Submodel for the query part of the response
struct ConvertsionQuery: Codable {
    let from: String
    let to: String
    let amount: Double
}

// Submodel for the info part of the response
struct ConvertsionInfo: Codable {
    let rate: Double
}
