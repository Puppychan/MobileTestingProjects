//
//  CurrencyFlag.swift
//  CurrencyConverter
//
//  Created by Nhung Tran Mai on 20/11/24.
//

import SwiftUI

struct CurrencyFlag: View {
    let currencyFlag: String?
    let size: Double
    var body: some View {
        if let flagImage = currencyFlag, let image = imageFromBase64(flagImage) {
            image
                .resizable()
                .scaledToFill()
                .frame(width: size, height: size)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .clipped()
        } else {
            Color.clear.frame(width: size, height: size)
        }

    }
}

