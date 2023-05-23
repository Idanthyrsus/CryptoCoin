//
//  Color.swift
//  CryptoCurrencySwiftUI
//
//  Created by Alexander Korchak on 25.04.2023.
//

import Foundation
import UIKit


extension UIColor {
    // Singletone to get an access to a particular color
    static let theme = ColorTheme()
}

/// Main colors used in the app. Check 'assets' folder to see how do they work for light and dark appearance
struct ColorTheme {
    let accent = UIColor(named: "AccentColor")
    let background = UIColor(named: "BackgroundColor")
    let green = UIColor(named: "GreenColor")
    let red = UIColor(named: "RedColor")
    let secondaryText = UIColor(named: "SecondaryTextColor")
}
