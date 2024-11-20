//
//  CurrencyChartView.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 20/11/2024.
//

import SwiftUI
import Charts


struct CurrencyChartView: View {
    @EnvironmentObject var viewModel: CurrencyViewModel
    
    //    let exchangeRates: [ExchangeRateModel]
    //    let currency: String
    
    var body: some View {
        VStack {
            Text("Exchange Rates for ")
                .font(.headline)
                .padding()
            if !viewModel.exchangeRates.isEmpty {
                let minRate = viewModel.exchangeRates.map { $0.rate }.min() ?? 0
                let maxRate = viewModel.exchangeRates.map { $0.rate }.max() ?? 0
                Text("\(viewModel.exchangeRates[0].date) - \(viewModel.exchangeRates[0].rate)")
                Chart(viewModel.exchangeRates) {
                    LineMark(
                        x: .value("Date", $0.date),
                        y: .value("Rate", $0.rate)
                    )
                    .symbol(Circle())
                    .interpolationMethod(.catmullRom)
                }
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
            
            viewModel.fetchTimeseries(startDate: getTimestamptz(10), endDate: getTimestamptz(), currencies: ["USD", "VND", "EUR"])
        }
    }
}

#Preview {
    CurrencyChartView()
}
