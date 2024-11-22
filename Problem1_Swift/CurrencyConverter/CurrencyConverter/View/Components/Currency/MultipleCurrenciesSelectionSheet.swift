//
//  MultipleCurrenciesSelectionSheet.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 21/11/2024.
//

import SwiftUI

struct MultipleCurrenciesSelectionSheet: View {
    @Binding var selectedCurrencies: [CurrencyFlagModel]
    let availableCurrencies: [CurrencyFlagModel]
    
    @Environment(\.dismiss) private var dismiss
    @State private var searchText: String = ""
    var filteredCurrencies: [CurrencyFlagModel] {
        if searchText.isEmpty {
            return availableCurrencies
        } else {
            return availableCurrencies.filter {
                $0.name.lowercased().contains(searchText.lowercased()) ||
                $0.code.lowercased().contains(searchText.lowercased())
            }
        }
    }
    let columns: [GridItem] = [
        GridItem(.fixed(50)), // Fixed width for the currency symbol column
        GridItem(.flexible()), // Flexible width for the currency info column
        GridItem(.fixed(50))
    ]
    var body: some View {
        
        NavigationView {
            ScrollViewReader { proxy in
                List {
                    ForEach(filteredCurrencies, id: \.code) { currency in
                        ItemRow(currency: currency, isSelected: selectedCurrencies.contains(where: { $0.code == currency.code }))
                    }
                }
                
                .onAppear {
                    // Scroll to the selected currency when the sheet appears
                    proxy.scrollTo(selectedCurrencies[0].code, anchor: .center)
                }
            }
            .searchable(text: $searchText)
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
    
    @ViewBuilder
    private func ItemRow(currency: CurrencyFlagModel, isSelected: Bool) -> some View {
        HStack(spacing: 10) {
            CurrencyFlag(currencyFlag: currency.flag, size: 28)
            
            Text("\(currency.name) (\(currency.code))")
                .font(.body)
                .foregroundColor(ThemeConstants.TEXT_COLOR)
            Spacer()
            if isSelected {
                Image(systemName: "checkmark")
                    .frame(width: 32, height: 32)
                    .foregroundColor(ThemeConstants.PRIMARY_COLOR)
            }
        }
        .id(currency.code) // Assign a unique ID for scrolling
        .onTapGesture {
            if let index = selectedCurrencies.firstIndex(where: { $0.code == currency.code }) {
                selectedCurrencies.remove(at: index)
            } else {
                selectedCurrencies.append(currency)
            }
        }
        
    }
    
    
}
