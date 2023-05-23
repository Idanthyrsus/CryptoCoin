//
//  Endpoint+Image.swift
//  CryptoSwiftUI
//
//  Created by Alexander Korchak on 20.05.2023.
//

import Foundation

extension Endpoint {

    static func images(symbol: String) -> Self {
        return Endpoint(path: symbol)
    }
}
