//
//  ContentView.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 20/11/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("Home", systemImage: "house.fill") }
            LatestRatesView()
                .tabItem { Label("Rates", systemImage: "house.fill") }
            SettingView()
                .tabItem { Label("Settings", systemImage: "gearshape") }
        }
        .foregroundColor(ThemeConstants.SECONDARY_TEXT_COLOR)
        .accentColor(ThemeConstants.TERTIARY_COLOR)
    }
}

#Preview {
    ContentView()
}
