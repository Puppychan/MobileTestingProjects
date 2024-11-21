import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userPreferences: UserPreferencesViewModel
    
    @Binding var selectedTab: ContentView.Tab
    @State private var fromAmount: Double = 0
    @State private var toAmount: Double = 0
    
    private var fromCurrency: Binding<CurrencyFlagModel> {
        Binding(
            get: { userPreferences.baseCurrency },
            set: { userPreferences.baseCurrency = $0 }
        )
    }
    
    private var toCurrency: Binding<CurrencyFlagModel> {
        Binding(
            get: { userPreferences.targetCurrencies.first ?? CurrencyFlagModel.defaultToCurrency },
            set: { newCurrency in
                if let index = userPreferences.targetCurrencies.firstIndex(where: { $0.code == newCurrency.code }) {
                    userPreferences.targetCurrencies[index] = newCurrency
                } else {
                    userPreferences.targetCurrencies.insert(newCurrency, at: 0)
                }
            }
        )
    }
    
    var body: some View {
        ScrollView(.vertical) {
            ViewThatFits {
                VStack(alignment: .leading) {
                    ThemeConstants.IMAGE_APP_LOGO
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50) // Resize the image to 50x50
                    Text("Welcome to app")
                        .font(.title)
                    Grid(horizontalSpacing: 5, verticalSpacing: 20) {
                        
                        CurrencyConvertCard(fromCurrency: fromCurrency, toCurrency: toCurrency, fromAmount: $fromAmount, toAmount: $toAmount)
                        
                        FromToCurrencyLineMark(fromCurrency: fromCurrency, toCurrency: toCurrency)
                        
                        GridRow {
                            CurrencyInfoCard(currency: fromCurrency)
                            //                        Color.clear.gridCellUnsizedAxes([.horizontal, .vertical])
                            
                            CurrencyInfoCard(currency: toCurrency)
                        }
                        
                        //                        tempCardMarking()
                        ConversionResultsSection(selectedTab: $selectedTab)
                        
                    }
                }
                .padding()
            }
            
        }
        
    }
    @ViewBuilder
    private func tempCardMarking() -> some View {
        Rectangle()
            .foregroundColor(ThemeConstants.BACKGROUND_COLOR)
            .cornerRadius(10)
            .frame(maxWidth: .infinity, idealHeight: 100)
            .shadow(radius: 3)
    }
}


