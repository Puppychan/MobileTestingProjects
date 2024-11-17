//
//  LatestRatesViewModel.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 16/11/2024.
//

import Foundation

class CurrencyViewModel: ObservableObject {
    @Published var renderedLatestResponse: LatestRatesResponse?
    @Published var renderedCurrencies: [String: CurrencyDetailModel]?
    @Published var conversionResponse: ConversionResponse?
    @Published var renderedTimeseriesResponse: TimeseriesResponse?
    @Published var renderedHistoricalConversionResponse: HistoricalConversionResponse?
    @Published var errorMessage: String?
    
    func fetchLatestRates() {
        let url = Constants.CURRENCY_API_URL + "latest"
        
        NetworkingManager.shared.fetch(from: url, responseType: LatestRatesResponse.self) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.renderedLatestResponse = response
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func fetchCurrencies() {
        let url = Constants.CURRENCY_API_URL + "currencies"
        
        NetworkingManager.shared.fetch(from: url, responseType: CurrenciesResponse.self) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.renderedCurrencies = response.currencies
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func convertCurrency(from: String, to: String, date: String, amount: Double, format: String = "json") {
//        let url = Constants.CURRENCY_API_URL + "convert"
        let url = "\(Constants.CURRENCY_API_URL)convert?from=\(from)&to=\(to)&amount=\(amount)&format=\(format)"
        
        NetworkingManager.shared.fetch(from: url, responseType: ConversionResponse.self) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.conversionResponse = response
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func fetchTimeseries() {
        let url = Constants.CURRENCY_API_URL + "timeseries"
        
        NetworkingManager.shared.fetch(from: url, responseType: TimeseriesResponse.self) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.renderedTimeseriesResponse = response
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func fetchHistoricalConversion() {
        let url = Constants.CURRENCY_API_URL + "historical"
        
        NetworkingManager.shared.fetch(from: url, responseType: HistoricalConversionResponse.self) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.renderedHistoricalConversionResponse = response
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
