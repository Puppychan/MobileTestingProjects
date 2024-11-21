//
//  ExchangeRateModel.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 20/11/2024.
//

import Foundation
struct ExchangeRateModel: Identifiable {
    // This is for Line chart
    let id = UUID()
    let date: Date
    let rate: Double
}
