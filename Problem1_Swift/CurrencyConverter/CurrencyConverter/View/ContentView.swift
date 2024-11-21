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
        TabView(selection: $selectedTab) {
            HomeView(selectedTab: $selectedTab)
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag(Tab.home)
            LatestRatesView()
                .tabItem { Label("Rates", systemImage: "house.fill") }
                .tag(Tab.rates)
            SettingView()
                .tabItem { Label("Settings", systemImage: "gearshape") }
                .tag(Tab.settings)
        }
        .foregroundColor(ThemeConstants.SECONDARY_TEXT_COLOR)
        .accentColor(ThemeConstants.TERTIARY_COLOR)
    }
}
