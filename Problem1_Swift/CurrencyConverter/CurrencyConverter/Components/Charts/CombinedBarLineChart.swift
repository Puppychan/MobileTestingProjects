//
//  CombinedBarLineChart.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 21/11/2024.
//

import SwiftUI
import Charts

struct CombinedBarLineChart: View {
    let currencyRates: [CurrencyRateModel]
    let latestRates: [CurrencyRateModel]
    
    var body: some View {
        Chart {
            // Line Marks for historical trends
            ForEach(uniqueCurrencies, id: \.self) { currencyCode in
                ForEach(currencyRates.filter { $0.currencyCode == currencyCode }) { rateModel in
                    LineMark(
                        x: .value("Date", rateModel.date),
                        y: .value("Rate", rateModel.rate),
                        series: .value("Currency", rateModel.currencyCode)
                    )
                    .foregroundStyle(by: .value("Currency", rateModel.currencyCode))
                }
            }
            
            // Bar Marks for the latest rates
            ForEach(latestRates) { rateModel in
                BarMark(
                    x: .value("Currency", rateModel.currencyCode),
                    y: .value("Rate", rateModel.rate)
                )
                .foregroundStyle(by: .value("Currency", rateModel.currencyCode))
            }
        }
        .chartLegend(position: .top)
        .frame(height: 300)
        .padding()
    }
    
    private var uniqueCurrencies: [String] {
        Set(currencyRates.map { $0.currencyCode }).sorted()
    }
}
