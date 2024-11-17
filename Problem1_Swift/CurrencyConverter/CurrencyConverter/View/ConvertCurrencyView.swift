import SwiftUI

enum FocusField {
    case fromAmount, toAmount
}

struct ConvertCurrencyView: View {
    @EnvironmentObject var viewModel: CurrencyViewModel
    
    @FocusState private var focusedField: FocusField?
    
    @State private var fromCurrency: CurrencyFlagModel = CurrencyFlagModel.defaultFromCurrency
    @State private var toCurrency: CurrencyFlagModel = CurrencyFlagModel.defaultToCurrency
    @State private var fromAmount: Double = 1000.00
    @State private var toAmount: Double = 736.70
    
    var body: some View {
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
            // Swap Button
            Button(action: swapCurrencies) {
                Image(systemName: "arrow.left.arrow.right")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .background(Color.blue)
                    .clipShape(Circle())
                    .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
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
        .onChange(of: viewModel.conversionResponse) {
            updateToAmount()
        }
    }
    
    private func updateToAmount() {
        if (focusedField == FocusField.fromAmount) {
            toAmount = viewModel.conversionResponse?.result ?? 0
        } else {
            fromAmount = viewModel.conversionResponse?.result ?? 0
        }
    }
    
    
    // Swap the "From" and "To" currencies
    private func swapCurrencies() {
        let temp = fromCurrency
        fromCurrency = toCurrency
        toCurrency = temp
    }
}


#Preview {
    ConvertCurrencyView()
}
