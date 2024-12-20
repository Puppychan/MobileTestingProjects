import SwiftUI

struct HomeView: View {
    @Binding var selectedTab: ContentView.Tab
    
    @EnvironmentObject var userPreferences: UserPreferencesViewModel
    
    @State private var fromAmount: Double = 0
    @State private var toAmount: Double = 0
    @State private var fromCurrency: CurrencyFlagModel = CurrencyFlagModel.defaultFromCurrency
    @State private var toCurrency: CurrencyFlagModel = CurrencyFlagModel.defaultToCurrency
    
    
    //    private var fromCurrency: Binding<CurrencyFlagModel> {
    //        Binding(
    //            get: { userPreferences.baseCurrency },
    //            set: { userPreferences.baseCurrency = $0 }
    //        )
    //    }
    //
    //    private var toCurrency: Binding<CurrencyFlagModel> {
    //        Binding(
    //            get: { userPreferences.targetCurrencies.first ?? CurrencyFlagModel.defaultToCurrency },
    //            set: { newCurrency in
    //                if let index = userPreferences.targetCurrencies.firstIndex(where: { $0.code == newCurrency.code }) {
    //                    userPreferences.targetCurrencies[index] = newCurrency
    //                } else {
    //                    userPreferences.targetCurrencies.insert(newCurrency, at: 0)
    //                }
    //            }
    //        )
    //    }
    
    
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
                        
                        CurrencyConvertCard(fromCurrency: $fromCurrency, toCurrency: $toCurrency, fromAmount: $fromAmount, toAmount: $toAmount)
                        
                        CustomDivider()
                        
                        FromToCurrencyLineMark(fromCurrency: $fromCurrency, toCurrency: $toCurrency)
                        
                        GridRow {
                            CurrencyInfoCard(currency: $fromCurrency)
                            
                            CurrencyInfoCard(currency: $toCurrency)
                        }
                        CustomDivider()
                        ConversionResultsSection(selectedTab: $selectedTab)
                    }
                }
                .padding()
                .onAppear() {
                    // Initialize fromCurrency and toCurrency using userPreferences
                    fromCurrency = userPreferences.baseCurrency
                    toCurrency = userPreferences.targetCurrencies.first ?? CurrencyFlagModel.defaultToCurrency
                }
            }
            
        }
        
    }
}


