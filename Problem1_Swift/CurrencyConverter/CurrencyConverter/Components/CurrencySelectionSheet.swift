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
    
    var body: some View {
        NavigationView {
            ScrollViewReader { proxy in
                List(availableCurrencies, id: \.code) { currency in
                    HStack {
                        if currency.code == selectedCurrency.code {
                            Image(systemName: "checkmark")
                                .font(.system(size: 20, weight: .bold)) // Adjust size and weight
                            
                        }
                        else if let flagImage = currency.flag, let image = imageFromBase64(flagImage) {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 32, height: 32)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .clipped()
                        } else {
                            Color.clear.frame(width: 32, height: 32)
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
