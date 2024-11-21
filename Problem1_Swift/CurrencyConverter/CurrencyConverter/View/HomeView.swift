import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userPreferences: UserPreferencesViewModel
    
    //    @State private var fromCurrency: CurrencyFlagModel = CurrencyFlagModel.defaultFromCurrency
    //    @State private var toCurrency: CurrencyFlagModel = CurrencyFlagModel.defaultToCurrency
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
        NavigationView {
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
                            ConversionResultsSection()
                            
                        }
                    }
                    .padding()
                }
                
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


struct ConversionResultsSection: View {
    @EnvironmentObject var userPreferences: UserPreferencesViewModel
    @EnvironmentObject var currencyViewModel: CurrencyViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Conversion Results")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("The unit based on your preferred's base currency and preferred's converting target currencies")
                .multilineTextAlignment(.leading)
                .font(.subheadline)
                .foregroundColor(ThemeConstants.SECONDARY_TEXT_COLOR)
                .italic()
                .padding(.bottom, 5)
            
            // Explanation of Base Currency
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Your Base Currency")
                                .font(.headline)
                                .foregroundColor(ThemeConstants.TEXT_COLOR)
                            HStack {
                                CurrencyFlag(currencyFlag: userPreferences.baseCurrency.flag, size: 32)
                                Text("\(userPreferences.baseCurrency.name) (\(userPreferences.baseCurrency.code))")
                                    .font(.body)
                                    .foregroundColor(ThemeConstants.TEXT_COLOR)
                            }
                            Divider()
                            Text("Below are conversions based on your selected target currencies from your preferences.")
                                .multilineTextAlignment(.leading)
                                .font(.subheadline)
                                .foregroundColor(ThemeConstants.SECONDARY_TEXT_COLOR)
                                .italic()
                        }
                        .padding(.bottom, 5)

                        // Modify Preferences Button
                        NavigationLink(destination: SettingView()) {
                            HStack {
                                Image(systemName: "gearshape")
                                    .foregroundColor(ThemeConstants.PRIMARY_COLOR)
                                Text("Modify Preferences")
                                    .font(.headline)
                                    .foregroundColor(ThemeConstants.PRIMARY_COLOR)
                            }
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(ThemeConstants.PRIMARY_COLOR, lineWidth: 1)
                            )
                        }
                        .padding(.bottom, 10)

            
            if let latestRates = currencyViewModel.renderedLatestResponse {
                ForEach(userPreferences.targetCurrencies, id: \.code) { currency in
                    if let rate = latestRates.rates[currency.code] {
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("\(currency.name) (\(currency.code))")
                                    .font(.headline)
                                Text("\(userPreferences.baseCurrency.symbol) 1 = \(currency.symbol)\(rate.formatted(.number.precision(.fractionLength(2))))")
                                    .font(.subheadline)
                                    .foregroundColor(ThemeConstants.SECONDARY_TEXT_COLOR)
                            }
                            Spacer()
                            CurrencyFlag(currencyFlag: currency.flag, size: 32)
                        }
                        .modifier(SecondaryBackgroundCardStyle())
                    }
                }
            } else {
                Text("Loading conversions...")
                    .font(.subheadline)
                    .foregroundColor(ThemeConstants.SECONDARY_TEXT_COLOR)
                    .padding()
            }
        }
        .modifier(BorderCardStyle())
        .onAppear {
            fetchConversionResults()
        }
    }
    
    private func fetchConversionResults() {
        
        let targetCodes = userPreferences.targetCurrencies.map { $0.code }
        let baseCode = userPreferences.baseCurrency.code
        
        currencyViewModel.fetchLatestRates(currencies: targetCodes, base: baseCode)
        
        
        
    }
}
