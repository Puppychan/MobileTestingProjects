//
//  LatestRatesView.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 16/11/2024.
//

import Foundation
import SwiftUI

struct LatestRatesView: View {
    @Binding var selectedTab: ContentView.Tab
    
    @EnvironmentObject var userPreferences: UserPreferencesViewModel
    @EnvironmentObject var currencyViewModel: CurrencyViewModel

    var body: some View {
        ScrollView {
            ViewThatFits {
                VStack {
                    
                    ConversionResultsSection(selectedTab: $selectedTab)
                }
                .navigationTitle("Latest")
            }
        }
        .onAppear {
            fetchLatestRates()
        }
    }
    
    private var mainCurrencySection: some View {
        VStack {
            if let latestRates = currencyViewModel.renderedLatestResponse {
                ForEach(userPreferences.targetCurrencies, id: \.code) { currency in
                    if let rate = latestRates.rates[currency.code] {
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("\(currency.name) (\(currency.code))")
                                    .font(.headline)
                                Text("\(userPreferences.baseCurrency.symbol) 1 = \(currency.symbol)\(rate.formatted(.number.precision(.fractionLength(2))))")
                                    .font(.subheadline)
                                    .foregroundColor(ThemeConstants.SECONDARY_TEXT_COLOR)
                            }
                            Spacer()
                            CurrencyFlag(currencyFlag: currency.flag, size: 32)
                        }
                        .modifier(SecondaryBackgroundCardStyle())
                    }
                }
            } else {
                Text("Loading conversions...")
                    .font(.subheadline)
                    .foregroundColor(ThemeConstants.SECONDARY_TEXT_COLOR)
                    .padding()
            }
        }
    }

    private func fetchLatestRates() {
        let targetCodes = userPreferences.targetCurrencies.map { $0.code }
        let baseCode = userPreferences.baseCurrency.code
        currencyViewModel.fetchUserPreferenceRates(currencies: targetCodes, base: baseCode)
        
        currencyViewModel.fetchLatestRates(currencies: ["EUR", "JPY"])
    }
}
