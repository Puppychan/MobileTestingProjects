//
//  CurrencyChartView.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 20/11/2024.
//

import SwiftUI
import Charts


struct FromToCurrencyLineMark: View {
    @EnvironmentObject var viewModel: CurrencyViewModel
    @StateObject var chartViewModel: CurrencyChartViewModel = CurrencyChartViewModel()
    
    @Binding var fromCurrency: CurrencyFlagModel
    @Binding var toCurrency: CurrencyFlagModel
    
    //    let exchangeRates: [ExchangeRateModel]
    //    let currency: String
    
    var body: some View {
        VStack {
            Text("Exchange Rates for \(toCurrency.code) - \(toCurrency.name)")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Text("Base Currency: \(fromCurrency.code) - \(fromCurrency.name)")
                .multilineTextAlignment(.center)
                .font(.subheadline)
            if !chartViewModel.exchangeRates.isEmpty {
                let minRate = chartViewModel.exchangeRates.map { $0.rate }.min() ?? 0
                let maxRate = chartViewModel.exchangeRates.map { $0.rate }.max() ?? 0
                
                Chart(chartViewModel.exchangeRates) {
                    LineMark(
                        x: .value("Date", $0.date),
                        y: .value("Rate", $0.rate)
                    )
                    .symbol(Circle())
                    .interpolationMethod(.catmullRom)
                }
                .chartScrollableAxes(.horizontal)
                .chartScrollTargetBehavior(
                    .valueAligned(
                        matching: DateComponents(minute: 0),
                        majorAlignment: .matching(DateComponents(hour: 0))
                    )
                )
                .chartYScale(domain: minRate...maxRate) // Scale based on min and max
                .frame(height: 300)
                .padding()
            } else {
                Text("Loading data...")
                    .font(.subheadline)
                    .foregroundColor(ThemeConstants.SECONDARY_TEXT_COLOR)
            }
        }
        .onAppear() {
            fetchTimeseriesCurrencies()
        }
        .onChange(of: fromCurrency) { oldResponse, newResponse in
            fetchTimeseriesCurrencies()
        }
        .onChange(of: toCurrency) { oldResponse, newResponse in
            fetchTimeseriesCurrencies()
        }
        .onChange(of: viewModel.renderedTimeseriesResponse) { oldResponse, newResponse in
            if let response = newResponse {
                chartViewModel.fetchExchangeRates(from: response, for: toCurrency.code)
            }
        }
        
    }
    
    private func fetchTimeseriesCurrencies() {
        viewModel.fetchTimeseries(startDate: getTimestamptz(10), endDate: getTimestamptz(), currencies: [toCurrency.code], base: fromCurrency.code)
    }
}
