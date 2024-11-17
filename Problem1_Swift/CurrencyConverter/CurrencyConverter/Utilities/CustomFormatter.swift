//
//  CustomFormatter.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 18/11/2024.
//

import Foundation


var decimalFormatter: NumberFormatter {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 3
    formatter.decimalSeparator = ","
    return formatter
}
