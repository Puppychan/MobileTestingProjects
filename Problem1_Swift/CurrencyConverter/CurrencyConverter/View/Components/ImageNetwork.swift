//
//  ImageNetwork.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 20/11/2024.
//

import SwiftUI

struct ImageNetwork: View {
    let size: Double
    let imageUrlString: String
    var body: some View {
        if let imageUrl = URL(string: imageUrlString) {
            AsyncImage(url: imageUrl) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: size, height: size)
                        .background(Color(.systemGray5))
                        .clipShape(Circle())
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: size, height: size)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                case .failure:
                    Image(systemName: "person.crop.circle.fill.badge.xmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: size, height: size)
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
        }
    }
}
