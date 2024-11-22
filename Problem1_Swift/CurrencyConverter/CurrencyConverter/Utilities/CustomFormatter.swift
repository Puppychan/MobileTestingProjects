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
    
    formatter.minimum = .init(floatLiteral: 1.0)
    formatter.maximum = .init(floatLiteral: Double.greatestFiniteMagnitude)
    
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 3
    
    formatter.maximumIntegerDigits = 15 // Limiting the maximum digits
    
    formatter.usesGroupingSeparator = true // Enables grouping (thousands separator)

    
    // Explicitly setting grouping and decimal separators
    formatter.groupingSeparator = ","
    formatter.decimalSeparator = "."
    
    
    
    return formatter
}
