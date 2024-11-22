//
//  HandleErrorWrap.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 22/11/2024.
//

import SwiftUI

struct HandleErrorWrap<Content: View>: View {
    let networkError: NetworkErrorEnum?
    let content: () -> Content
    
    var body: some View {
        if let error = networkError {
            if (error == .noInternetConnection) {
                ErrorView(errorMessage: error.errorDescription ?? "No Internet Connection", iconName: "wifi.exclamationmark")
            } else {
                ErrorView(errorMessage: "There is something wrong. Please try again later!", iconName: "exclamationmark.triangle.fill")
                
            }
        } else {
            content()
        }
    }
}

struct ErrorView: View {
    let errorMessage: String
    let iconName: String

    var body: some View {
        VStack(spacing: 3) {
            Image(systemName: iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(ThemeConstants.ERROR_COLOR)
            Text(errorMessage)
                .font(.headline)
                .foregroundColor(ThemeConstants.ERROR_COLOR)
                .multilineTextAlignment(.center)
                .padding()
        }
        .modifier(BorderCardStyle())
    }
}
