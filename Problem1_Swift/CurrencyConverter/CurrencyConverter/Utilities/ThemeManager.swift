//
//  ThemeManager.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 20/11/2024.
//

import SwiftUI

class ThemeManager: ObservableObject {
    @AppStorage("selectedTheme") private var storedTheme: Theme = .system {
        didSet {
            // Only update currentTheme if it's different from storedTheme
            if currentTheme != storedTheme {
                currentTheme = storedTheme
            }
        }
    }
    
    @Published var currentTheme: Theme = .system {
        didSet {
            if currentTheme != storedTheme {
                // Only update storedTheme if it's different from currentTheme
                storedTheme = currentTheme
            }
            // Always update the appearance when currentTheme changes
            updateAppearance()
        }
    }
    
    init() {
        // Sync currentTheme with storedTheme on initialization
        // This will trigger the didSet of currentTheme, which handles appearance updating
        currentTheme = storedTheme
    }
    
    /// Updates the app's appearance based on the selected theme
    private func updateAppearance() {
        let interfaceStyle: UIUserInterfaceStyle
        switch currentTheme {
        case .system:
            interfaceStyle = .unspecified
        case .light:
            interfaceStyle = .light
        case .dark:
            interfaceStyle = .dark
        }
        
        applyAppearance(interfaceStyle)
    }
    
    /// Applies the appearance to the active window scene
    private func applyAppearance(_ interfaceStyle: UIUserInterfaceStyle) {
        DispatchQueue.main.async {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            for window in windowScene.windows {
                window.overrideUserInterfaceStyle = interfaceStyle
            }
        }
    }
    
    /// Explicitly sets the theme; use this method to change the theme programmatically
    func updateTheme(_ theme: Theme) {
        guard currentTheme != theme else { return }
        currentTheme = theme
    }
}
