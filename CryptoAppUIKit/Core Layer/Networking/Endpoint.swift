//
//  Endpoint.swift
//  CryptoSwiftUI
//
//  Created by Alexander Korchak on 20.05.2023.
//

import Foundation

/// Structure which represents endpoint to create url request
struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}
