//
//  CurrencyConverterView.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 15/11/2024.
//

import SwiftUI

struct CurrencyConverterView: View {
    @StateObject private var viewModel = CurrencyConverterViewModel()
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Currency Converter")
                    .font(.largeTitle)
                    .bold()

                TextField("Enter Amount", value: $viewModel.amount, formatter: formatter)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                HStack {
                    Picker("From", selection: $viewModel.selectedFromCurrency) {
                        ForEach(viewModel.currencies, id: \.self) { currency in
                            Text(currency)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())

                    Text("to")

                    Picker("To", selection: $viewModel.selectedToCurrency) {
                        ForEach(viewModel.currencies, id: \.self) { currency in
                            Text(currency)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }

                Button(action: viewModel.convertCurrency) {
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding()
                    } else {
                        Text("Convert")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .disabled(viewModel.isLoading)

                if !viewModel.convertedAmount.isEmpty {
                    Text("Converted Amount: \(viewModel.convertedAmount)")
                        .font(.title2)
                        .padding()
                }

                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }

                Spacer()
            }
            .padding()
        }
    }
}
#Preview {
    CurrencyConverterView()
}
