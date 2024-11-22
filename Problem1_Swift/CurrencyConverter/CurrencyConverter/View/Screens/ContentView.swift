//
//  ContentView.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 20/11/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .home
    
    enum Tab {
        case home, rates, settings
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                HomeView(selectedTab: $selectedTab)
                    .tabItem { Label("Home", systemImage: "house.fill") }
                    .tag(Tab.home)
                LatestRatesView(selectedTab: $selectedTab)
                    .tabItem { Label("Rates", systemImage: "chart.bar") }
                    .tag(Tab.rates)
                SettingView()
                    .tabItem { Label("Settings", systemImage: "gearshape") }
                    .tag(Tab.settings)
            }
            .foregroundColor(ThemeConstants.SECONDARY_TEXT_COLOR)
            .accentColor(ThemeConstants.TERTIARY_COLOR)
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
}

extension View {
    /// Dismiss the keyboard globally
    func hideKeyboard() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            scene.keyWindow?.endEditing(true)
        }
    }
}
