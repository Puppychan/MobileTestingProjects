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

            Chart(viewModel.exchangeRates) {
                LineMark(
                    x: .value("Date", $0.date),
                    y: .value("Rate", $0.rate)
                )
                .symbol(Circle())
                .interpolationMethod(.catmullRom)
            }
            .frame(height: 300)
            .padding()
        }
        .onAppear() {
            
            viewModel.fetchTimeseries(startDate: String, endDate: <#T##String#>)
        }
    }
}

#Preview {
    CurrencyChartView()
}
