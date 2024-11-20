//
//  CurrencySelectionSheet.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 17/11/2024.
//
import SwiftUI

struct CurrencySelectionSheet: View {
    @Binding var selectedCurrency: CurrencyFlagModel
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
    
    var body: some View {
        NavigationView {
            ScrollViewReader { proxy in
                List(filteredCurrencies, id: \.code) { currency in
                    HStack {
                        if currency.code == selectedCurrency.code {
                            Image(systemName: "checkmark")
                                .font(.system(size: 20, weight: .bold)) // Adjust size and weight
                            
                        }
                        else {
                            CurrencyFlag(currencyFlag: currency.flag, size: 32)
                        }
                        
                        Text(currency.name)
                        
                        Spacer()
                        
                        Text(currency.code)
                        
                    }
                    .id(currency.code) // Assign a unique ID for scrolling
                    .onTapGesture {
                        selectedCurrency = currency
                        dismiss()
                    }
                }
                .onAppear {
                    // Scroll to the selected currency when the sheet appears
                    proxy.scrollTo(selectedCurrency.code, anchor: .center)
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
}
