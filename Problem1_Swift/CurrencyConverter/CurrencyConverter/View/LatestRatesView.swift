//
//  LatestRatesView.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 16/11/2024.
//

import Foundation
import SwiftUI

struct LatestRatesView: View {
    @StateObject private var viewModel = CurrencyViewModel() // Initialize the ViewModel

    var body: some View {
        NavigationView {
            VStack {
//                if let errorMessage = viewModel.errorMessage {
//                    // Show error message if any
//                    Text("Error: \(errorMessage)")
//                        .foregroundColor(.red)
//                        .multilineTextAlignment(.center)
//                        .padding()
//                } else if viewModel.renderedLatestResponse == nil {
//                    // Show a loading indicator while data is being fetched
//                    ProgressView("Fetching latest rates...")
//                        .padding()
//                } else {
//                    // Show the rates in a list
//                    List(viewModel.rates.sorted(by: { $0.key < $1.key }), id: \.key) { currency, rate in
//                        HStack {
//                            Text(currency)
//                                .font(.headline)
//                            Spacer()
//                            Text("\(rate, specifier: "%.4f")")
//                                .font(.subheadline)
//                        }
//                    }
//                }
            }
            .navigationTitle("Latest Rates")
            .onAppear {
                viewModel.fetchLatestRates() // Fetch the latest rates when the view appears
            }
        }
    }
}

#Preview {
    LatestRatesView()
}
