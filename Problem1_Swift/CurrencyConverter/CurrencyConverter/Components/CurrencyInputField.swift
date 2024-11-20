import SwiftUI

struct CurrencyInputField: View {
    @Binding var amount: Double
    @Binding var selectedCurrency: CurrencyFlagModel
    @Binding var targetCurrency: CurrencyFlagModel
    let isFocused: Bool
    let viewModel: CurrencyViewModel
    let title: String
    
    @State private var isSheetPresented: Bool = false
    @State private var userInput: String = ""
    @State private var debounceWorkItem: DispatchWorkItem? // Debounce handler
    
    
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(ThemeConstants.SECONDARY_TEXT_COLOR)
                
                HStack {
                    // Currency Symbol and Amount
                    Text(selectedCurrency.symbol)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(ThemeConstants.TEXT_COLOR)
                    
                    TextField("", text: $userInput, onEditingChanged: { _ in }, onCommit: {})
                        .keyboardType(.decimalPad)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(ThemeConstants.TEXT_COLOR)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity)
                        .onReceive(userInput.publisher.collect()) {
                            handleUserInputChange($0)
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
                .background(ThemeConstants.BACKGROUND_COLOR)
                .cornerRadius(10)
        )
        .onChange(of: amount) { newAmount in
            // Keep userInput in sync with amount changes
            // Only call to receive update outside the input field - Not focused field
            if (!isFocused) {
                syncUserInputWithAmount()
            }
        }
    }
    
    @ViewBuilder
    private func currencyButtonContent() -> some View {
        CurrencyFlag(currencyFlag: selectedCurrency.flag, size: 32)
        Text(selectedCurrency.code)
            .font(.headline)
            .foregroundColor(ThemeConstants.TEXT_COLOR)
        Image(systemName: "chevron.down")
            .foregroundColor(ThemeConstants.SECONDARY_TEXT_COLOR)
    }
    
    private func syncUserInputWithAmount() {
        userInput = decimalFormatter.string(from: NSNumber(value: amount)) ?? ""
    }
    
    private func sanitizeInput(_ input: String) -> String {
        // Ensure input only contains valid characters
        input.filter { $0.isNumber || $0 == "." || $0 == "," }.replacingOccurrences(of: ",", with: "")
    }
    
    /// Handle changes to the user input, validate and format
    private func handleUserInputChange(_ input: [String.Element]) {
        // Define source of rawInput
        // If not main convert field, get amount to display formatted number
        let rawInput: String
        if isFocused {
            rawInput = sanitizeInput(String(input))
        } else {
            rawInput = sanitizeInput(String(amount))
        }
        
        // Format string to number
        guard let formattedNumber = decimalFormatter.number(from: rawInput) else {
            // If input is invalid, show the sanitized string without invalid characters
            userInput = ""
            return
        }
        let newAmount = formattedNumber.doubleValue
        
        // Prevent redundant updates (onReceive call twice - prevent spamming API
        if amount != newAmount {
            amount = newAmount
            // Only call API if main convert input field
            if (isFocused) {
                handleAmountChange(newValue: amount)
            }
        }
        
        // Format number back to string with desired format number
        var finalString = decimalFormatter.string(from: formattedNumber) ?? ""
        // Handle case where formattedInput ends with a '.'
        // If the input ends with a ".", append "0" to make it valide
        if rawInput.hasSuffix(".") {
            finalString.append(".")
        }
        userInput = finalString
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
