//
//  CurrencySelectionSheet.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 17/11/2024.
//

import Foundation
import SwiftUI

struct CurrencySelectionSheet: View {
    @Binding var selectedCurrency: CurrencyDetailModel
    let availableCurrencies: [String: CurrencyDetailModel]

    @Environment(\.dismiss) private var dismiss // For dismissing the sheet

    var body: some View {
        NavigationView {
            List(availableCurrencies.keys.sorted(), id: \.self) { currencyKey in
                            HStack {
                                // Display the currency name or symbol
                                Text(availableCurrencies[currencyKey]?.name ?? currencyKey)
                                
                                Spacer()
                                
                                // Show checkmark if this is the selected currency
                                if availableCurrencies[currencyKey]?.name == selectedCurrency.name {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                }
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                if let currency = availableCurrencies[currencyKey] {
                                    selectedCurrency = currency
                                    dismiss() // Close the sheet
                                }
                            }
                        }
            .navigationTitle("Select Currency")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}
