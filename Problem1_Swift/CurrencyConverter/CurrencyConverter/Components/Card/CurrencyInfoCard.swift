//
//  CurrencyInfoCard.swift
//  CurrencyConverter
//
//  Created by Nhung Tran Mai on 20/11/24.
//

import SwiftUI

struct CurrencyInfoCard: View {
    @Binding var currency: CurrencyFlagModel
    var body: some View {
        VStack(alignment: .leading) {
            CurrencyFlag(currencyFlag: currency.flag, size: 32)
            HStack {
                Text(currency.country)
                    .font(.subheadline)
                    .lineLimit(1)
                    .foregroundColor(ThemeConstants.TEXT_COLOR)
                Spacer()
                labelText("From")
            }
            HStack {
                Text(currency.countryCode.uppercased())
                    .font(.footnote)
                    .lineLimit(1)
                    .foregroundColor(ThemeConstants.SECONDARY_TEXT_COLOR)
                Spacer()
                labelText("Country Name")
            }
            
            Divider()
            HStack {
                Text("\(currency.symbol) \(currency.code)")
                    .font(.body)
                    .lineLimit(1)
                    .foregroundColor(ThemeConstants.TEXT_COLOR)
                Spacer()
                labelText("Currency")
            }
            HStack {
                Text(currency.name)
                    .font(.footnote)
                    .lineLimit(1)
                    .foregroundColor(ThemeConstants.SECONDARY_TEXT_COLOR)
                Spacer()
                labelText("Full name")
            }
            
        }
        .modifier(BorderCardStyle())
        .frame(maxWidth: .infinity)
    }
    @ViewBuilder
    private func labelText(_ label: String) -> some View {
        Text(label)
            .frame(alignment: .bottomTrailing)
            .font(.caption)
            .foregroundColor(ThemeConstants.SECONDARY_TEXT_COLOR)
    }
}
