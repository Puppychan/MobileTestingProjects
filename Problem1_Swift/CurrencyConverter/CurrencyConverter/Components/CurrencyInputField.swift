import SwiftUI

struct CurrencyInputField: View {
    @Binding var amount: Double
    @Binding var selectedCurrency: CurrencyFlagModel
    @Binding var targetCurrency: CurrencyFlagModel
    let isFocused: Bool
    let viewModel: CurrencyViewModel
    let title: String
    
    @State private var isSheetPresented: Bool = false
    @State private var userInput: Double = 0.0
    @State private var debounceWorkItem: DispatchWorkItem? // Debounce handler
    
    var decimalFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 3
        formatter.usesGroupingSeparator = true // Enables grouping (thousands separator)
        
        // Explicitly set the locale to a known locale that uses comma separators, if needed
        // Uncomment the next line to force a specific locale
        // formatter.locale = Locale(identifier: "en_US")
        
        // Explicitly setting grouping and decimal separators
        formatter.groupingSeparator = ","
        formatter.decimalSeparator = "."
        
        formatter.maximumIntegerDigits = 15 // Limiting the maximum digits
        
        
        return formatter
    }
    
    
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                HStack {
                    // Currency Symbol and Amount
                    Text(selectedCurrency.symbol)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    TextField("", value: $userInput, formatter: decimalFormatter)
                        .keyboardType(.decimalPad)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity)
                        .onChange(of: userInput) {
                            let clampedValue = min(max(userInput, 0), 10_000_000_000) // Adjust max value as appropriate
                            if clampedValue.isFinite && isFocused {
                                handleAmountChange(newValue: clampedValue)
                            } else {
                                // Log or handle invalid or out of range values
                                print("Invalid or out of range number encountered: \(userInput)")
                                userInput = 10_000_000_000.0
                            }
                        }
                }
            }
            
            Spacer()
            
            // Currency Picker Trigger Button
            Button(action: {
                isSheetPresented = true
            }) {
                currencyButtonContent()
            }
            .sheet(isPresented: $isSheetPresented) {
                CurrencySelectionSheet(selectedCurrency: $selectedCurrency, availableCurrencies: viewModel.renderedCurrencies ?? [])
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .leading, endPoint: .trailing), lineWidth: isFocused ? 4 : 2)
                .background(Color.white)
                .cornerRadius(12)
        )
        .shadow(color: .gray.opacity(0.2), radius: 8, x: 0, y: 4)
        .onChange(of: amount) {
            userInput = amount
        }
    }
    
    @ViewBuilder
    private func currencyButtonContent() -> some View {
        if let flagImage = selectedCurrency.flag, let image = imageFromBase64(flagImage) {
            image
                .resizable()
                .scaledToFill()
                .frame(width: 32, height: 32)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .clipped()
        } else {
            Color.clear.frame(width: 32, height: 32)
        }
        Text(selectedCurrency.code)
            .font(.headline)
            .foregroundColor(.black)
        Image(systemName: "chevron.down")
            .foregroundColor(.gray)
    }
    
    
    /// Handle changes to the input amount with debounce
    private func handleAmountChange(newValue: Double) {
        // Cancel the previous debounce action
        debounceWorkItem?.cancel()
        
        // Create a new debounce action
        let workItem = DispatchWorkItem { [weak viewModel] in
            guard let viewModel = viewModel else { return }
            // Call the convert function with updated parameters
            viewModel.convertCurrency(
                from: selectedCurrency.code,
                to: targetCurrency.code,
                amount: newValue
            )
        }
        
        debounceWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: workItem) // 500ms debounce
    }
    
}
