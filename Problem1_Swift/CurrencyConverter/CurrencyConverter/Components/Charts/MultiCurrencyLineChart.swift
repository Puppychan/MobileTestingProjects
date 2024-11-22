//
//  MultiCurrencyLineChart.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 21/11/2024.
//

import SwiftUI
import Charts

struct MultiCurrencyLineChart: View {
    @EnvironmentObject var viewModel: CurrencyViewModel
    @StateObject var chartViewModel: CurrencyChartViewModel = CurrencyChartViewModel()
    @State private var isLoading: Bool = true
    @State private var errorMessage: String?
    
    let currencies: [String] // List of currencies to display
    let baseCurrency: String = "USD" // Fixed base currency for the chart
    
    var body: some View {
        VStack {
            Text("Currency Rates of Currencies in the World (Base: \(baseCurrency))")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            if isLoading {
                ProgressView("Loading data...")
                    .padding()
            } else if let errorMessage = errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
            } else if !chartViewModel.currencyRates.isEmpty {
                ScrollView(.horizontal) {
                    Chart {
                        ForEach(currencies, id: \.self) { currency in
                            let normalizedData = normalizedCurrencyRates(for: currency)
                            ForEach(normalizedData, id: \.id) { rate in
                                LineMark(
                                    x: .value("Date", rate.date),
                                    y: .value("Normalized Rate (%)", rate.rate),
                                    series: .value("Currency", rate.currencyCode)
                                )
                                .foregroundStyle(by: .value("Currency", rate.currencyCode))
                            }
                        }
                    }
                    .chartLegend(position: .top)
                    .frame(height: 300)
                    .padding()
                    .frame(minWidth: CGFloat(chartViewModel.currencyRates.count) * 50) // Adjust width dynamically
                }
            } else {
                Text("No data available.")
                    .foregroundColor(.gray)
                    .padding()
            }
        }
        .onAppear {
            fetchCurrencyRates()
        }
        .onChange(of: viewModel.renderedTimeseriesResponse) { oldResponse, newResponse in
            guard let response = newResponse else { return }
            chartViewModel.fetchCurrencyRates(from: response)
            isLoading = false
        }
    }
    
    private func fetchCurrencyRates() {
        isLoading = true
        errorMessage = nil
        
        viewModel.fetchTimeseries(
            startDate: getTimestamptz(10),
            endDate: getTimestamptz(),
            currencies: currencies,
            base: baseCurrency
        )
    }
    
    /// Normalize the currency rates to a percentage change from the first value
    private func normalizedCurrencyRates(for currency: String) -> [CurrencyRateModel] {
        let rates = chartViewModel.currencyRates.filter { $0.currencyCode == currency }
        guard let firstRate = rates.first?.rate else { return [] }
        
        return rates.map { rateModel in
            let normalizedRate = ((rateModel.rate - firstRate) / firstRate) * 100 // Percentage change
            return CurrencyRateModel(date: rateModel.date, currencyCode: rateModel.currencyCode, rate: normalizedRate)
        }
    }
}
