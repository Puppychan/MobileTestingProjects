import SwiftUI

struct HomeView: View {
    @State private var fromCurrency: CurrencyFlagModel = CurrencyFlagModel.defaultFromCurrency
    @State private var toCurrency: CurrencyFlagModel = CurrencyFlagModel.defaultToCurrency
    @State private var fromAmount: Double = 0
    @State private var toAmount: Double = 0
    
    
    var body: some View {
        ScrollView(.vertical) {
            ViewThatFits {
                VStack(alignment: .leading) {
                    ThemeConstants.IMAGE_APP_LOGO
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50) // Resize the image to 50x50
                    Text("Welcome to app")
                        .padding()
                    Grid(horizontalSpacing: 5, verticalSpacing: 20) {
                        
                        CurrencyConvertCard(fromCurrency: $fromCurrency, toCurrency: $toCurrency, fromAmount: $fromAmount, toAmount: $toAmount)
                        
                        //                        tempCardMarking()
                        CurrencyChartView()
                        
                        GridRow {
                            tempCardMarking()
                            //                        Color.clear.gridCellUnsizedAxes([.horizontal, .vertical])
                            
                            tempCardMarking()
                        }
                        
                        tempCardMarking()
                        
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


#Preview {
    HomeView()
}
