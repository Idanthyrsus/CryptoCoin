//
//  UIView+Extensions.swift
//  EffectiveMobileTest
//
//  Created by Alexander Korchak on 11.03.2023.
//

import Foundation
import UIKit

extension UIView {
    func addSubviews(_ views : [UIView]) {
        // Looping through UIView elements to add them to the main view
        for item in views {
            self.addSubview(item)
        }
    }
}
