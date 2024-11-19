import SwiftUI

enum FocusField {
    case fromAmount, toAmount
}

struct ConvertCurrencyView: View {
    @EnvironmentObject var viewModel: CurrencyViewModel
    
    @FocusState private var focusedField: FocusField?
    
    @State private var fromCurrency: CurrencyFlagModel = CurrencyFlagModel.defaultFromCurrency
    @State private var toCurrency: CurrencyFlagModel = CurrencyFlagModel.defaultToCurrency
    @State private var fromAmount: Double = 0
    @State private var toAmount: Double = 0
    
    var body: some View {
        
        if #available(iOS 17.0, *) {
            createExchangeContentView()
                .onChange(of: viewModel.conversionResponse) {
                    updateToAmount()
                }
        } else {
            // Fallback on earlier versions
            createExchangeContentView()
                .onChange(of: viewModel.conversionResponse) { _ in
                    updateToAmount()
                }
            
        }
    }
    
    @ViewBuilder
    private func createExchangeContentView() -> some View {
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
        .background(Color(.systemGray6))
        .cornerRadius(20)
        .shadow(color: .gray.opacity(0.3), radius: 10, x: 0, y: 5)
        .padding()
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


#Preview {
    ConvertCurrencyView()
}
