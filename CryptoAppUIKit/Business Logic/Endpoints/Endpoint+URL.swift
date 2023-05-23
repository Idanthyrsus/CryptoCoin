//
//  Endpoint+URL.swift
//  CryptoSwiftUI
//
//  Created by Alexander Korchak on 20.05.2023.
//

import Foundation

extension Endpoint {
    
   static let baseUrl = "https://api.coincap.io/v2/assets"
    
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.coincap.io"
        components.path = "/v2" + path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Wrong url components: \(components)")
        }
        
        return url
    }
}
