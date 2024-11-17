import SwiftUI

struct CurrencyInputField: View {
    @Binding var amount: String
    @Binding var selectedCurrency: CurrencyFlagModel
    let viewModel: CurrencyViewModel
    let title: String
    
    @State private var isSheetPresented: Bool = false // State to control the sheet
    
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                HStack {
                    // Currency Symbol and Amount
                    Text(selectedCurrency.symbol)
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
                    if let flagImage = selectedCurrency.flag, let image = imageFromBase64(flagImage) {
                        image
                            .resizable()
                            .scaledToFill() // Ensures the image fills the frame
                            .frame(width: 32, height: 32) // Set the size
                            .clipShape(RoundedRectangle(cornerRadius: 10)) // Clip to a circle
                            .clipped() // Ensure content outside the frame is clipped
                    } else {
                        Color.clear.frame(width: 32, height: 32)
                    }
                    Text(selectedCurrency.code)
                        .font(.headline)
                        .foregroundColor(.black)
                    // Add caret icon
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray) // Adjust color as needed
                }
                .padding(5)
                .cornerRadius(10)
            }
            .sheet(isPresented: $isSheetPresented) {
                CurrencySelectionSheet(
                    selectedCurrency: $selectedCurrency,
                    availableCurrencies: viewModel.renderedCurrencies ?? []
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
        //        .onAppear {
        //            viewModel.fetchCurrencies()
        //        }
    }
}
