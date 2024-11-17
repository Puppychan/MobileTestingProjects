import SwiftUI

struct ConvertCurrencyView: View {
    @EnvironmentObject var viewModel: CurrencyViewModel

    @State private var fromCurrency: CurrencyFlagModel = CurrencyFlagModel.defaultFromCurrency
    @State private var toCurrency: CurrencyFlagModel = CurrencyFlagModel.defaultToCurrency
    @State private var fromAmount: String = "1000.00"
    @State private var toAmount: String = "736.70"

    var body: some View {
        VStack(spacing: 20) {
            // Top Section: From Currency
            CurrencyInputField(
                            amount: $fromAmount,
                            selectedCurrency: $fromCurrency,
                            viewModel: viewModel,
                            title: "You Send"
            )
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
                            viewModel: viewModel,
                            title: "Converted Amount"
                        )
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(20)
        .shadow(color: .gray.opacity(0.3), radius: 10, x: 0, y: 5)
        .padding()
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
