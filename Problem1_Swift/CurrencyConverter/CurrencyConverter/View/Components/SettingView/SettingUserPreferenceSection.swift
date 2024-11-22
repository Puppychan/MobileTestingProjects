//
//  SettingUserPreferenceSection.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 21/11/2024.
//

import SwiftUI

struct SettingUserPreferenceSection: View {
    @EnvironmentObject var userPreferences: UserPreferencesViewModel
    @EnvironmentObject var currencyViewModel: CurrencyViewModel
    
    var body: some View {
        SettingSectionCard(title: "User Preferences") {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Base Currency:")
                        .font(.headline)
                    Spacer()
                }
                
                CurrencyPicker(
                    selectedCurrency: $userPreferences.baseCurrency,
                    availableCurrencies: currencyViewModel.renderedCurrencies ?? []
                )
                
                CustomDivider()
                    .padding(.vertical)
                
                HStack {
                    Text("Target Currencies:")
                        .font(.headline)
                    Spacer()
                }
                
                MultipleCurrenciesPicker(selectedCurrencies: $userPreferences.targetCurrencies, availableCurrencies: currencyViewModel.renderedCurrencies ?? [])
                
            }
        }
    }
}

struct CurrencyPicker: View {
    @Binding var selectedCurrency: CurrencyFlagModel
    let availableCurrencies: [CurrencyFlagModel]
    
    @State private var isSheetPresented = false
    
    var body: some View {
        Button(action: {
            isSheetPresented.toggle()
        }) {
            HStack {
                if let flag = selectedCurrency.flag {
                    CurrencyFlag(currencyFlag: flag, size: 28)
                }
                VStack(alignment: .leading) {
                    Text(selectedCurrency.name)
                        .font(.headline)
                        .foregroundColor(ThemeConstants.TEXT_COLOR)
                        .lineLimit(1)
                    Text("\(selectedCurrency.code) - \(selectedCurrency.symbol)")
                        .font(.subheadline)
                        .foregroundColor(ThemeConstants.SECONDARY_TEXT_COLOR)
                        .lineLimit(1)
                    
                }
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundColor(ThemeConstants.SECONDARY_TEXT_COLOR)
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)) // Customize padding for each edge
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(ThemeConstants.SECONDARY_COLOR, lineWidth: 1)
            )
        }
        .sheet(isPresented: $isSheetPresented) {
            CurrencySelectionSheet(
                selectedCurrency: $selectedCurrency,
                availableCurrencies: availableCurrencies
            )
        }
    }
}

struct MultipleCurrenciesPicker: View {
    @Binding var selectedCurrencies: [CurrencyFlagModel]
    let availableCurrencies: [CurrencyFlagModel]
    
    @State private var isSheetPresented = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            ForEach(selectedCurrencies, id: \.code) { currency in
                HStack {
                    if let flag = currency.flag {
                        CurrencyFlag(currencyFlag: flag, size: 20)
                    }
                    Text("\(currency.name) (\(currency.code))")
                        .font(.subheadline)
                }
                .padding(.vertical, 2)
            }
        }
        
        Button(action: {
            isSheetPresented.toggle()
        }) {
            HStack {
                Image(systemName: "plus.circle")
                Text("Add/Remove Target Currencies")
                    .font(.subheadline)
            }
        }
        .sheet(isPresented: $isSheetPresented) {
            MultipleCurrenciesSelectionSheet(availableCurrencies: availableCurrencies)
        }
        
    }
}
