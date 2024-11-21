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
    @State private var showingBaseCurrencyPicker = false
    @State private var showingTargetCurrencyPicker = false
    var availableCurrencies: [String] = ["USD", "EUR", "JPY", "GBP", "CAD"] // Example currency list
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
                
                Divider()
                    .padding(.vertical)
                
                HStack {
                    Text("Target Currencies:")
                        .font(.headline)
                    Spacer()
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    ForEach(userPreferences.targetCurrencies, id: \.code) { currency in
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
                    showingTargetCurrencyPicker = true
                }) {
                    HStack {
                        Image(systemName: "plus.circle")
                        Text("Add/Remove Target Currencies")
                            .font(.subheadline)
                    }
                }
                .sheet(isPresented: $showingTargetCurrencyPicker) {
//                    MultiCurrencyPickerView(
//                        selectedCurrencies: $userPreferences.targetCurrencies,
//                        availableCurrencies: currencyViewModel.renderedCurrencies ?? [],
//                        title: "Select Target Currencies"
//                    )
                    MultipleCurrenciesSelectionSheet(selectedCurrencies: $userPreferences.targetCurrencies, availableCurrencies: currencyViewModel.renderedCurrencies ?? [])
                }
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

struct MultiCurrencyPickerView: View {
    @Binding var selectedCurrencies: [CurrencyFlagModel]
    let availableCurrencies: [CurrencyFlagModel]
    let title: String

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            List(availableCurrencies, id: \.code) { currency in
                MultipleSelectionRow(
                    title: "\(currency.name) (\(currency.code))",
                    isSelected: selectedCurrencies.contains(where: { $0.code == currency.code })
                ) {
                    if let index = selectedCurrencies.firstIndex(where: { $0.code == currency.code }) {
                        selectedCurrencies.remove(at: index)
                    } else {
                        selectedCurrencies.append(currency)
                    }
                }
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .foregroundColor(.primary)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(.blue)
                }
            }
            .padding()
        }
    }
}
