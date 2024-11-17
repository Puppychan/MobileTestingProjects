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
    
    func fetchLatestRates(
        currencies: [String]? = nil,
        base: String? = "USD",
        amount: Double? = 1,
        places: Int? = nil,
        format: String? = "json" // Default to "json"
    ) {
        // Build the URL with query parameters
        var urlComponents = URLComponents(
            string: Constants.CURRENCY_API_URL + "latest"
        )
        var queryItems: [URLQueryItem] = []
        
        if let currencies = currencies {
            queryItems.append(
                URLQueryItem(
                    name: "currencies",
                    value: currencies.joined(
                        separator: ","
                    )
                )
            )
        }
        if let base = base {
            queryItems.append(
                URLQueryItem(
                    name: "base",
                    value: base
                )
            )
        }
        if let amount = amount {
            queryItems.append(
                URLQueryItem(
                    name: "amount",
                    value: String(
                        amount
                    )
                )
            )
        }
        if let places = places {
            queryItems.append(
                URLQueryItem(
                    name: "places",
                    value: String(
                        places
                    )
                )
            )
        }
        if let format = format {
            queryItems.append(
                URLQueryItem(
                    name: "format",
                    value: format
                )
            )
        }
        
        urlComponents?.queryItems = queryItems
        guard let url = urlComponents?.url else {
            self.errorMessage = "Invalid URL"
            return
        }
        
        NetworkingManager.shared.fetch(
            from: url.absoluteString,
            responseType: LatestRatesResponse.self
        ) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(
                    let response
                ):
                    self?.renderedLatestResponse = response
                case .failure(
                    let error
                ):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func fetchCurrencies() {
        let url = Constants.CURRENCY_API_URL + "currencies"
        
        NetworkingManager.shared.fetch(
            from: url,
            responseType: CurrenciesResponse.self
        ) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(
                    let response
                ):
                    self?.renderedCurrencies = response.currencies
                case .failure(
                    let error
                ):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func convertCurrency(
        from: String,
        to: String,
        amount: Double,
        date: String? = nil,
        places: Int? = nil,
        format: String? = "json"
    ) {
        //        let url = Constants.CURRENCY_API_URL + "convert"
        // Build the URL with query parameters
        var urlComponents = URLComponents(
            string: Constants.CURRENCY_API_URL + "latest"
        )
        var queryItems: [URLQueryItem] = []
        
        queryItems.append(
            URLQueryItem(
                name: "from",
                value: from
            )
        )
        queryItems.append(
            URLQueryItem(
                name: "to",
                value: to
            )
        )
        queryItems.append(
            URLQueryItem(
                name: "amount",
                value: String(
                    amount
                )
            )
        )
        
        if let date = date {
            queryItems.append(
                URLQueryItem(
                    name: "date",
                    value: date
                )
            )
        }
        if let places = places {
            queryItems.append(
                URLQueryItem(
                    name: "places",
                    value: String(
                        places
                    )
                )
            )
        }
        if let format = format {
            queryItems.append(
                URLQueryItem(
                    name: "format",
                    value: format
                )
            )
        }
        
        urlComponents?.queryItems = queryItems
        guard let url = urlComponents?.url else {
            self.errorMessage = "Invalid URL"
            return
        }
        
        NetworkingManager.shared.fetch(
            from: url.absoluteString,
            responseType: ConversionResponse.self
        ) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(
                    let response
                ):
                    self?.conversionResponse = response
                case .failure(
                    let error
                ):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func fetchTimeseries(
        startDate: String,
        endDate: String,
        accuracy: CurrencyAccuracyEnum? = CurrencyAccuracyEnum.day,
        currencies: [String]? = nil,
        base: String? = "USD",
        places: Int? = nil,
        format: String? = "json"
    ) {
        //        let url = Constants.CURRENCY_API_URL + "timeseries"
        // Initialize URL components
        var urlComponents = URLComponents(
            string: Constants.CURRENCY_API_URL + "timeseries"
        )
        var queryItems: [URLQueryItem] = []
        
        // Required parameters
        queryItems.append(
            URLQueryItem(
                name: "start_date",
                value: startDate
            )
        )
        queryItems.append(
            URLQueryItem(
                name: "end_date",
                value: endDate
            )
        )
        
        // Optional parameters
        if let accuracy = accuracy {
            queryItems.append(
                URLQueryItem(
                    name: "accuracy",
                    value: accuracy.rawValue
                )
            )
        }
        if let currencies = currencies {
            queryItems.append(
                URLQueryItem(
                    name: "currencies",
                    value: currencies.joined(
                        separator: ","
                    )
                )
            )
        }
        if let base = base {
            queryItems.append(
                URLQueryItem(
                    name: "base",
                    value: base
                )
            )
        }
        if let places = places {
            queryItems.append(
                URLQueryItem(
                    name: "places",
                    value: String(
                        places
                    )
                )
            )
        }
        if let format = format {
            queryItems.append(
                URLQueryItem(
                    name: "format",
                    value: format
                )
            )
        }
        
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else {
            self.errorMessage = "Invalid URL"
            return
        }
        
        NetworkingManager.shared.fetch(
            from: url.absoluteString,
            responseType: TimeseriesResponse.self
        ) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(
                    let response
                ):
                    self?.renderedTimeseriesResponse = response
                case .failure(
                    let error
                ):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func fetchHistoricalConversion(
        date: String? = nil,
        base: String? = "USD",
        currencies: [String]? = nil,
        amount: Double? = 1,
        places: Int? = nil,
        format: String? = "json"
    ) {
        //        let url = Constants.CURRENCY_API_URL + "historical"
        // Initialize URL components
        var urlComponents = URLComponents(
            string: Constants.CURRENCY_API_URL + "historical"
        )
        var queryItems: [URLQueryItem] = []
        queryItems.append(
            URLQueryItem(
                name: "api_key",
                value: Constants.CURRENCY_API_KEY
            )
        )
        
        // Required parameter (if date is provided)
        if let date = date {
            queryItems.append(
                URLQueryItem(
                    name: "date",
                    value: date
                )
            )
        }
        
        // Optional parameters
        if let base = base {
            queryItems.append(
                URLQueryItem(
                    name: "base",
                    value: base
                )
            )
        }
        if let currencies = currencies {
            queryItems.append(
                URLQueryItem(
                    name: "currencies",
                    value: currencies.joined(
                        separator: ","
                    )
                )
            )
        }
        if let amount = amount {
            queryItems.append(
                URLQueryItem(
                    name: "amount",
                    value: String(
                        amount
                    )
                )
            )
        }
        if let places = places {
            queryItems.append(
                URLQueryItem(
                    name: "places",
                    value: String(
                        places
                    )
                )
            )
        }
        if let format = format {
            queryItems.append(
                URLQueryItem(
                    name: "format",
                    value: format
                )
            )
        }
        
        urlComponents?.queryItems = queryItems
        
        // Ensure the final URL is valid
        guard let url = urlComponents?.url else {
            self.errorMessage = "Invalid URL"
            return
        }
        
        NetworkingManager.shared.fetch(
            from: url.absoluteString,
            responseType: HistoricalConversionResponse.self
        ) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(
                    let response
                ):
                    self?.renderedHistoricalConversionResponse = response
                case .failure(
                    let error
                ):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
