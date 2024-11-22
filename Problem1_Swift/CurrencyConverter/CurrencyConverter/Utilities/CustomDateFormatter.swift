//
//  CustomDateFormatter.swift
//  CurrencyConverter
//
//  Created by Nhung Tran Mai on 20/11/24.
//

import Foundation

/// Get the current and past `timestamptz` strings
/// - Parameters:
///   - daysAgo: Number of days in the past to calculate the timestamp - if nil -> return current date timestamptz
func getTimestamptz(_ daysAgo: Int? = nil) -> String {
    let isoFormatter = ISO8601DateFormatter()
    isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    
    let currentDate = Date() // Current date and time
    
    // If not nil -> return desired timestamptz >< If nil -> return current date timestamptz
    if (daysAgo != nil && daysAgo != 0) {
        let pastDate = Calendar.current.date(byAdding: .day, value: -daysAgo!, to: currentDate)!
        return isoFormatter.string(from: pastDate)
    } else {
        return isoFormatter.string(from: currentDate)
    }

}

func fromTimestamptzToDate(_ dateString: String) -> Date? {
    let isoFormatter = ISO8601DateFormatter()
    isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    return isoFormatter.date(from: dateString)
    
}
