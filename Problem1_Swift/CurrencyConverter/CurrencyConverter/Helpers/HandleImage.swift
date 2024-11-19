//
//  HandleImage.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 18/11/2024.
//

import SwiftUI

func imageFromBase64(_ base64String: String) -> Image? {
    // Remove the prefix if it exists
    let prefix = "data:image/png;base64,"
    let cleanBase64 = base64String.hasPrefix(prefix) ? String(base64String.dropFirst(prefix.count)) : base64String
    
    // Decode the Base64 string
    guard let imageData = Data(base64Encoded: cleanBase64),
          let uiImage = UIImage(data: imageData) else {
        return nil // Return nil if decoding fails
    }
    
    return Image(uiImage: uiImage)
}
