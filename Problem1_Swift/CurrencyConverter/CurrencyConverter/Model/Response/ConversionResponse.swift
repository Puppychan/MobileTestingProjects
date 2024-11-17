//
//  ConvertResponse.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 16/11/2024.
//

import Foundation

import Foundation

// Root model for the conversion response
struct ConversionResponse: Codable, Equatable {
    static func == (lhs: ConversionResponse, rhs: ConversionResponse) -> Bool {
        return fabs(lhs.result - rhs.result) < Double.ulpOfOne && lhs.query == rhs.query && lhs.info == rhs.info
    }
    
    let success: Bool
    let query: ConvertsionQuery
    let info: ConvertsionInfo
    let historical: Bool
    let date: String
    let timestamp: Int
    let result: Double
}

// Submodel for the query part of the response
struct ConvertsionQuery: Codable, Equatable {
    static func == (lhs: ConvertsionQuery, rhs: ConvertsionQuery) -> Bool {
        return fabs(lhs.amount - rhs.amount) < Double.ulpOfOne && lhs.from == rhs.from && lhs.to == rhs.to
    }
    let from: String
    let to: String
    let amount: Double
}

// Submodel for the info part of the response
struct ConvertsionInfo: Codable, Equatable {
    static func == (lhs: ConvertsionInfo, rhs: ConvertsionInfo) -> Bool {
        return fabs(lhs.rate - rhs.rate) < Double.ulpOfOne
    }
    let rate: Double
}
