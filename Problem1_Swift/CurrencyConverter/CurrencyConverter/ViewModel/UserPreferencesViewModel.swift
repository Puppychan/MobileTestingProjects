//
//  UserPreferencesViewModel.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 21/11/2024.
//

import Foundation

class UserPreferencesViewModel: ObservableObject {
    @Published var baseCurrency: CurrencyFlagModel {
        didSet {
            saveCurrencyToDefaults(currency: baseCurrency, key: "UserBaseCurrency")
        }
    }
    
    @Published var targetCurrencies: [CurrencyFlagModel] {
        didSet {
            saveCurrenciesToDefaults(currencies: targetCurrencies, key: "UserTargetCurrencies")
        }
    }
    

    init() {
        // Use local variables to ensure `self` is not accessed prematurely
        let loadedBaseCurrency = Self.loadCurrencyFromDefaults(key: "UserBaseCurrency") ?? CurrencyFlagModel.defaultFromCurrency
        let loadedTargetCurrencies = Self.loadCurrenciesFromDefaults(key: "UserTargetCurrencies") ?? [CurrencyFlagModel.defaultToCurrency]
        
        self.baseCurrency = loadedBaseCurrency
        self.targetCurrencies = loadedTargetCurrencies
    }
    
    func addCurrencyToTargets(currency: CurrencyFlagModel) {
        guard !targetCurrencies.contains(currency) else { return }
        targetCurrencies.append(currency)
    }
    
    func removeCurrencyFromTargets(currency: CurrencyFlagModel) {
        targetCurrencies.removeAll { $0 == currency }
        print("Target currencies \(targetCurrencies)")
        // Ensure at least one target currency remains; fallback to the default
        if targetCurrencies.isEmpty {
            targetCurrencies = [CurrencyFlagModel.defaultToCurrency]
        }
    }
    
    // MARK: - UserDefaults Handling
    
    private func saveCurrencyToDefaults(currency: CurrencyFlagModel, key: String) {
        if let encoded = try? JSONEncoder().encode(currency) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    private func saveCurrenciesToDefaults(currencies: [CurrencyFlagModel], key: String) {
        if let encoded = try? JSONEncoder().encode(currencies) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    private static func loadCurrencyFromDefaults(key: String) -> CurrencyFlagModel? {
        if let data = UserDefaults.standard.data(forKey: key),
           let currency = try? JSONDecoder().decode(CurrencyFlagModel.self, from: data) {
            return currency
        }
        return nil
    }
    
    
    private static func loadCurrenciesFromDefaults(key: String) -> [CurrencyFlagModel]? {
        if let data = UserDefaults.standard.data(forKey: key),
           let currencies = try? JSONDecoder().decode([CurrencyFlagModel].self, from: data) {
            return currencies
        }
        return nil
    }
}
