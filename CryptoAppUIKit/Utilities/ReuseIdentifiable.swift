//
//  ReuseIdentifiable.swift
//  EffectiveMobileTest
//
//  Created by Alexander Korchak on 11.03.2023.
//

import Foundation
import UIKit

// protocol which created reuseIdentifier as String for UITableViewCell
protocol ReuseIdentifiable: AnyObject {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifiable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UIView: ReuseIdentifiable {
    
}
