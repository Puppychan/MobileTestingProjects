//
//  MultiCurrencyLineChart.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 21/11/2024.
//

import SwiftUI
import Charts

struct MultiCurrencyLineChart: View {
    @StateObject var chartViewModel: CurrencyChartViewModel
    
    let currencies: [String] // List of currencies to display
    let baseCurrency: String
    
    var body: some View {
        VStack {
            Text("Currency Rates of Currencies in the World (Base: \(baseCurrency))")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            if !chartViewModel.currencyRates.isEmpty {
//                ScrollView(.horizontal) {
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
                    .chartScrollableAxes(.horizontal)
//                    .chartScrollTargetBehavior(
//                        .valueAligned(
//                            matching: DateComponents(minute: 0),
//                            majorAlignment: .matching(DateComponents(hour: 0))
//                        )
//                    )
                    .chartLegend(position: .top)
                    .frame(height: 300)
                    .padding()
//                    .frame(minWidth: CGFloat(chartViewModel.currencyRates.count) * 50) // Adjust width dynamically
//                }
            } else {
                Text("No data available.")
                    .foregroundColor(.gray)
                    .padding()
            }
        }
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
