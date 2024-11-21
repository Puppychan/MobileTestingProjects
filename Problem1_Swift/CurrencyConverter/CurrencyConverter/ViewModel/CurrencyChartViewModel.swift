//
//  CurrencyChartViewModel.swift
//  CurrencyConverter
//
//  Created by Nhung Tran Mai on 20/11/24.
//

import Foundation
class CurrencyChartViewModel: ObservableObject {
    @Published var exchangeRates: [ExchangeRateModel] = []
    @Published var currencyRates: [CurrencyRateModel] = []
    
    func fetchExchangeRates(from timeseriesResponse: TimeseriesResponse, for currency: String) {
            self.exchangeRates = timeseriesResponse.getExchangeRates(for: currency)
        }
    
    func fetchCurrencyRates(from timeseriesResponse: TimeseriesResponse) {
        self.currencyRates = timeseriesResponse.toCurrencyRateModels()
    }
}
