//
//  SettingView.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 20/11/2024.
//

import SwiftUI

enum Theme: String, CaseIterable, Identifiable {
    case system = "System"
    case light = "Light"
    case dark = "Dark"
    
    var id: String { self.rawValue }
    
    var description: String {
        switch self {
        case .system: return "Automatically matches the system-wide appearance."
        case .light: return "Light mode, suitable for bright environments."
        case .dark: return "Dark mode, suitable for low-light environments."
        }
    }
}

struct SettingView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                ViewThatFits {
                    VStack(spacing: 10) {
                        createSettingSection()
                        aboutMeSection
                    }
                }
                .padding()
                .navigationTitle("Settings")
                
            }
        }
    }
    @ViewBuilder
    private func createSettingSection() -> some View {
        SettingSectionCard(title: "Appearance") {
            ForEach(Theme.allCases) { theme in
                HStack {
                    VStack(alignment: .leading) {
                        Text(theme.rawValue)
                            .font(.headline)
                            .foregroundColor(ThemeConstants.TEXT_COLOR)
                        
                        Text(theme.description)
                            .font(.subheadline)
                            .foregroundColor(ThemeConstants.SECONDARY_TEXT_COLOR)
                    }
                    Spacer()
                    
                    // Radio Button
                    Image(systemName: themeManager.currentTheme == theme ? "checkmark.circle.fill" : "circle")
                        .font(.system(size: 25))
                        .foregroundColor(ThemeConstants.PRIMARY_COLOR)
                    
                }
                .modifier(SecondaryBackgroundCardStyle())
                .onTapGesture {
                    themeManager.updateTheme(theme)
                }
            }
        }
        
        SettingUserPreferenceSection()
        
    }
    private var aboutMeSection: some View {
        
        HStack {
            // Profile Image
            ImageNetwork(
                size: 75,
                imageUrlString: "https://instagram.fsgn2-4.fna.fbcdn.net/v/t51.2885-15/463892200_18437439154069033_5052462578200894743_n.jpg?stp=dst-jpg_e35&efg=eyJ2ZW5jb2RlX3RhZyI6ImltYWdlX3VybGdlbi4xNDQweDE0NDAuc2RyLmY3NTc2MS5kZWZhdWx0X2ltYWdlIn0&_nc_ht=instagram.fsgn2-4.fna.fbcdn.net&_nc_cat=101&_nc_ohc=M3R1bgnlLMIQ7kNvgGIH4ZY&_nc_gid=84817a57f9494a4fbbce65e4338e364a&edm=AP4sbd4BAAAA&ccb=7-5&ig_cache_key=MzQ4MjM5MzIzOTI3NjUxMjUwNA%3D%3D.3-ccb7-5&oh=00_AYDoBaYCxpTMr4m1hYCI6e5zvh5NbhJq7Z5HceAE1WXBuA&oe=6743DC28&_nc_sid=7a9f4b")
            Spacer()
            
            VStack {
                Text("Hi, I'm Nhung Tran")
                    .foregroundColor(ThemeConstants.TEXT_COLOR)
                    .font(.headline)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                
                Text("A passionate iOS developer who loves building beautiful and functional apps. Let's connect!")
                    .foregroundColor(ThemeConstants.SECONDARY_TEXT_COLOR)
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
            }
            .padding(.leading)
        }
        .modifier(BorderCardStyle())
        
    }
    
}
