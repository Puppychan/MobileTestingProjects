//
//  ConversionResultSection.swift
//  CurrencyConverter
//
//  Created by Nhung Tran Mai on 21/11/24.
//

import SwiftUI
struct ConversionResultsSection: View {
    @EnvironmentObject var userPreferences: UserPreferencesViewModel
    @EnvironmentObject var currencyViewModel: CurrencyViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Conversion Results")
                .font(.title2)
                .fontWeight(.bold)
            
            // Explanation of Base Currency
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Your Base Currency")
                                .font(.headline)
                                .foregroundColor(ThemeConstants.TEXT_COLOR)
                            HStack {
                                CurrencyFlag(currencyFlag: userPreferences.baseCurrency.flag, size: 32)
                                Text("\(userPreferences.baseCurrency.name) (\(userPreferences.baseCurrency.code))")
                                    .font(.body)
                                    .foregroundColor(ThemeConstants.TEXT_COLOR)
                            }
                            Divider()
                            Text("Below are conversions based on your selected target currencies from your preferences.")
                                .multilineTextAlignment(.leading)
                                .font(.subheadline)
                                .foregroundColor(ThemeConstants.SECONDARY_TEXT_COLOR)
                                .italic()
                        }
                        .padding(.bottom, 5)

                        // Modify Preferences Button
                        NavigationLink(destination: SettingView()) {
                            HStack {
                                Image(systemName: "gearshape")
                                    .foregroundColor(ThemeConstants.PRIMARY_COLOR)
                                Text("Modify Preferences")
                                    .font(.headline)
                                    .foregroundColor(ThemeConstants.PRIMARY_COLOR)
                            }
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(ThemeConstants.PRIMARY_COLOR, lineWidth: 1)
                            )
                        }
                        .padding(.bottom, 10)

            
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
        .modifier(BorderCardStyle())
        .onAppear {
            fetchConversionResults()
        }
    }
    
    private func fetchConversionResults() {
        
        let targetCodes = userPreferences.targetCurrencies.map { $0.code }
        let baseCode = userPreferences.baseCurrency.code
        
        currencyViewModel.fetchLatestRates(currencies: targetCodes, base: baseCode)
        
        
        
    }
}
