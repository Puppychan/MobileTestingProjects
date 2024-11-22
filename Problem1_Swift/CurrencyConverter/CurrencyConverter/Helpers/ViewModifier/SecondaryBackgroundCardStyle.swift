//
//  SecondaryBackgroundCardStyle.swift
//  CurrencyConverter
//
//  Created by Nhung Tran Mai on 21/11/24.
//
import SwiftUI

struct SecondaryBackgroundCardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(ThemeConstants.SECONDARY_COLOR)
            .cornerRadius(10)
    }
}
