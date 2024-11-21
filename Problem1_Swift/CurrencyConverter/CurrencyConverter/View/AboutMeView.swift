//
//  AboutMeView.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 20/11/2024.
//

import SwiftUI

struct AboutMeView: View {
    var body: some View {
        ScrollView(.vertical) {
            ViewThatFits {
                VStack {
                    if let imageUrl = URL(string: "https://github-readme-stats.vercel.app/api?username=Puppychan&theme=aura_dark&show_icons=true&count_private=true") {
                        AsyncImage(url: imageUrl) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: .infinity)
                                    .background(Color(.systemGray5))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: .infinity)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .shadow(radius: 5)
                            case .failure:
                                Image(systemName: "person.crop.circle.fill.badge.xmark")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: .infinity)
                                    .foregroundColor(.gray)
                            @unknown default:
                                EmptyView()
                            }
                        }
                    }
                }
                .navigationTitle("Developer Information")
            }
        }
    }
}

#Preview {
    AboutMeView()
}
