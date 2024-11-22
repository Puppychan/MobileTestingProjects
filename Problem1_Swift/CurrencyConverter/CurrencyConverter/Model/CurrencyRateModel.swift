//
//  CurrencyRateModel.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 21/11/2024.
//

import Foundation
struct CurrencyRateModel: Identifiable {
    // THis is for Multi-Series Line Chart
    let id = UUID()
    let date: Date
    let currencyCode: String
    let rate: Double
}
