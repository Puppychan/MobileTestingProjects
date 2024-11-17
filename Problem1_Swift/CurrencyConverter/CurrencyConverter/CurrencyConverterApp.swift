//
//  CurrencyConverterApp.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 15/11/2024.
//

import SwiftUI

@main
struct CurrencyConverterApp: App {
    init() {
        // Ensure CurrencyFlagManager loads the JSON when the app starts
        _ = CurrencyFlagManager.shared
    }

    var body: some Scene {
        WindowGroup {
            ConvertCurrencyView()
                .environmentObject(CurrencyViewModel()) // Provide CurrencyViewModel globally

        }
    }
}
