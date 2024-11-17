//
//  CurrencyConverterViewModel.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 15/11/2024.
//

import Foundation

class CurrencyConverterViewModel: ObservableObject {
    @Published var amount: String = ""
    @Published var convertedAmount: String = ""
    @Published var selectedFromCurrency: String = "USD"
    @Published var selectedToCurrency: String = "EUR"
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false

    let currencies = ["USD", "EUR", "GBP", "JPY", "INR"]

    func convertCurrency() {
        guard let amountValue = Double(amount) else {
            errorMessage = "Invalid amount entered."
            return
        }

        isLoading = true
        errorMessage = ""

        // Replace with a real API endpoint later
        let urlString = "https://example.com/currency-conversion/\(selectedFromCurrency)/\(selectedToCurrency)"

//        NetworkingManager.shared.fetch(urlString: urlString) { [weak self] (result: Result<ExchangeRateResponse, NetworkError>) in
//            DispatchQueue.main.async {
//                self?.isLoading = false
//                switch result {
//                case .success(let response):
//                    self?.convertedAmount = String(format: "%.2f", amountValue * response.conversionRate)
//                case .failure(let error):
//                    self?.errorMessage = error.localizedDescription
//                }
//            }
//        }
    }
}
