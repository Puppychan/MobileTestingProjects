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
    @StateObject var chartViewModel: CurrencyChartViewModel = CurrencyChartViewModel()

    var body: some View {
        ScrollView(.vertical) {
            ViewThatFits {
                VStack {
                    mainCurrencySection
                    if ((currencyViewModel.renderedTimeseriesResponse != nil) && (currencyViewModel.renderedLatestResponse != nil)) {
                        MultiCurrencyLineChart(currencies: ["EUR", "JPY", "GBP", "CAD", "SGD"])
                    } else {
                        Text("Loading chart...")
                            .font(.subheadline)
                            .foregroundColor(ThemeConstants.SECONDARY_TEXT_COLOR)
                            .padding()
                    }
                    ConversionResultsSection(selectedTab: $selectedTab)
                }
                .padding()
                .navigationTitle("Latest")
            }
        }
        .onChange(of: currencyViewModel.renderedTimeseriesResponse) { newResponse in
            if let response = newResponse {
                chartViewModel.fetchCurrencyRates(from: response)
            }
        }
        .onAppear {
            fetchLatestRates()
        }
    }
    
    private var mainCurrencySection: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let latestRates = currencyViewModel.renderedLatestResponse {
                // Display the base currency information
                VStack(alignment: .leading, spacing: 8) {
                    Text("Base Currency")
                        .font(.headline)
                        .foregroundColor(ThemeConstants.TEXT_COLOR)
                    HStack {
                        CurrencyFlag(currencyFlag: userPreferences.baseCurrency.flag, size: 32)
                        Text("\(userPreferences.baseCurrency.name) (\(userPreferences.baseCurrency.code))")
                            .font(.body)
                            .foregroundColor(ThemeConstants.TEXT_COLOR)
                    }
                    Divider()
                    Text("Below are the latest conversion rates:")
                        .font(.subheadline)
                        .foregroundColor(ThemeConstants.SECONDARY_TEXT_COLOR)
                        .italic()
                }
                .padding(.bottom, 10)

                // Loop through all rates in the latestRates response
                ForEach(latestRates.rates.sorted(by: { $0.key < $1.key }), id: \.key) { currencyCode, rate in
                    if let currency = currencyViewModel.renderedCurrencies?.first(where: { $0.code == currencyCode }) {
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
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(.systemGray6))
                        )
                        .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
                    }
                }
            } else {
                // Loading state
                Text("Loading conversion rates...")
                    .font(.subheadline)
                    .foregroundColor(ThemeConstants.SECONDARY_TEXT_COLOR)
                    .padding()
            }
        }
        .padding()
        .modifier(BorderCardStyle())
    }

    private func fetchLatestRates() {
        let currencyList = ["EUR", "JPY", "GBP", "CAD", "SGD"]
        currencyViewModel.fetchLatestRates(currencies: currencyList)
        currencyViewModel.fetchTimeseries(startDate: getTimestamptz(7), endDate: getTimestamptz(), currencies: currencyList)
    }
}
