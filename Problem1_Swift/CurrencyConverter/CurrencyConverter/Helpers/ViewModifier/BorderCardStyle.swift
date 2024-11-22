//
//  BorderCardStyle.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 21/11/2024.
//

import SwiftUI

struct BorderCardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(ThemeConstants.BACKGROUND_COLOR.opacity(0.3))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(ThemeConstants.TERTIARY_COLOR, lineWidth: 1)
            )
            .cornerRadius(10)
    }
}
