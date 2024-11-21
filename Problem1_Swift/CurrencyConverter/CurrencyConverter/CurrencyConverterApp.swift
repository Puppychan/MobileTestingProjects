//
//  CurrencyConverterApp.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 15/11/2024.
//

import SwiftUI

@main
struct CurrencyConverterApp: App {
    @StateObject private var themeManager = ThemeManager()

    init() {
        // Ensure CurrencyFlagManager loads the JSON when the app starts
        _ = CurrencyFlagManager.shared
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(themeManager)
                .environmentObject(CurrencyViewModel()) // Provide CurrencyViewModel globally
                .environmentObject(UserPreferencesViewModel())

        }
    }
}
