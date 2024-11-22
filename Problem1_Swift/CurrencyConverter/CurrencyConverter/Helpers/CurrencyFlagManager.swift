//
//  CurrencyJsonManager.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 17/11/2024.
//

import Foundation

class CurrencyFlagManager {
    static let shared = CurrencyFlagManager() // Singleton instance
    
    private(set) var currencies: [CurrencyFlagModel] = [] // Loaded currencies
    
    private init() {
        loadCurrencies()
    }
    
    private func loadCurrencies() {
        // Check if the data is already loaded (just in case this method is called again)
        guard currencies.isEmpty else { return }
        
        let paths = Bundle.main.paths(forResourcesOfType: "json", inDirectory: nil)
        print("Available JSON files in bundle: \(paths)")
        
        guard let url = Bundle.main.url(forResource: "final_currencies", withExtension: "json") else {
            print("Currencies JSON file not found")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            currencies = try decoder.decode([CurrencyFlagModel].self, from: data)
            //            print("Currencies loaded successfully: \(currencies)")
            
        } catch {
            print("Error decoding currencies JSON: \(error)")
        }
    }
    
    #if DEBUG
        func testableLoadCurrencies() {
            loadCurrencies()
        }
    #endif
}
