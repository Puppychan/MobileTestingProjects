//
//  CurrencyAccuracyEnum.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 17/11/2024.
//

import Foundation
enum CurrencyAccuracyEnum: String {
    case day = "day"
    case hours = "hours"
    case m15 = "15m"
    case m10 = "10m"
    case m5 = "5m"
    case m1 = "1m"

    /// Description of availability for each accuracy level.
    var description: String {
        switch self {
        case .day:
            return "Rates are available for the last 365 days - render daily"
        case .hours:
            return "Rates are available for the last 90 days - render hourly"
        case .m15:
            return "Rates are available for the last 7 days - render every 15 minutes"
        case .m10:
            return "Rates are available for the last 7 days - render every 10 minutes"
        case .m5:
            return "Rates are available for the last 7 days - render every 5 minutes"
        case .m1:
            return "Rates are available for the last 7 days - render every 1 minute"
        }
    }
}
