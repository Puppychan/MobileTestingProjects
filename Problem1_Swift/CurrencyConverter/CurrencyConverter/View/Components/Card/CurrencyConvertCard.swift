//
//  CurrencyConvertCard.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 19/11/2024.
//

import SwiftUI


enum FocusField {
    case fromAmount, toAmount
}

struct CurrencyConvertCard: View {
    @EnvironmentObject var viewModel: CurrencyViewModel
    
    @FocusState private var focusedField: FocusField?
    
    @Binding var fromCurrency: CurrencyFlagModel
    @Binding var toCurrency: CurrencyFlagModel
    @Binding var fromAmount: Double
    @Binding var toAmount: Double
    
    var body: some View {
        
        if #available(iOS 17.0, *) {
            exchangeContentView
                .onChange(of: viewModel.conversionResponse) {
                    updateToAmount()
                }
        } else {
            // Fallback on earlier versions
            exchangeContentView
                .onChange(of: viewModel.conversionResponse) { _ in
                    updateToAmount()
                }
        }
    }
    
    private var exchangeContentView: some View {
        VStack(spacing: 20) {
            // Top Section: From Currency
            CurrencyInputField(
                amount: $fromAmount,
                selectedCurrency: $fromCurrency,
                targetCurrency: $toCurrency,
                isFocused: focusedField == FocusField.fromAmount,
                viewModel: viewModel,
                title: "You Send"
            )
            .focused($focusedField, equals: .fromAmount)
            .onTapGesture {
                self.focusedField = .fromAmount
            }
            
            // Bottom Section: To Currency
            CurrencyInputField(
                amount: $toAmount,
                selectedCurrency: $toCurrency,
                targetCurrency: $fromCurrency,
                isFocused: focusedField == FocusField.toAmount,
                viewModel: viewModel,
                title: "Converted Amount"
            )
            .focused($focusedField, equals: .toAmount)
            .onTapGesture {
                self.focusedField = .toAmount
            }
        }
        .padding()
        .background(LinearGradient(colors: [ThemeConstants.TERTIARY_COLOR.opacity(0.3), ThemeConstants.PRIMARY_COLOR.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing).opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 5)
        //        .shadow(color: .gray.opacity(0.3), radius: 10, x: 0, y: 5)
    }
    
    private func updateToAmount() {
        guard let result = viewModel.conversionResponse?.result else {
            if focusedField == .fromAmount { toAmount = 0 } else { fromAmount = 0 }
            return
        }
        
        // Based on current focused input -> choose which input field to update the result
        if focusedField == .fromAmount {
            toAmount = result
        } else {
            fromAmount = result
        }
    }
}
