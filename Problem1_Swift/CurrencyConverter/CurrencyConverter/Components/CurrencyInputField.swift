import SwiftUI

struct CurrencyInputField: View {
    @Binding var amount: String
    @Binding var selectedCurrency: CurrencyDetailModel
    let viewModel: CurrencyViewModel
    let title: String
    
    @State private var isSheetPresented: Bool = false // State to control the sheet

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                HStack {
                    // Currency Symbol and Amount
                    Text(selectedCurrency.symbolNative)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    TextField("0.00", text: $amount)
                        .keyboardType(.decimalPad)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity)
                }
            }
            
            Spacer()

            // Currency Picker Trigger Button
            Button(action: {
                isSheetPresented = true
            }) {
                HStack {
                    // Replace with actual flag images if available
                    Image(systemName: "flag.fill") // Placeholder flag
                        .resizable()
                        .frame(width: 24, height: 24)
                        .clipShape(Circle())
                        .padding(.trailing, 5)
                    
                    Text(selectedCurrency.name)
                        .font(.headline)
                        .foregroundColor(.black)
                }
                .padding(5)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
            }
            .sheet(isPresented: $isSheetPresented) {
                CurrencySelectionSheet(
                    selectedCurrency: $selectedCurrency,
                    availableCurrencies: viewModel.renderedCurrencies ?? [:]
                )
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .leading, endPoint: .trailing), lineWidth: 2)
                .background(Color.white)
                .cornerRadius(12)
        )
        .shadow(color: .gray.opacity(0.2), radius: 8, x: 0, y: 4)
        .onAppear {
            viewModel.fetchCurrencies()
        }
    }
}
