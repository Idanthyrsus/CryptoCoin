//
//  ImageEndpoint.swift
//  CryptoSwiftUI
//
//  Created by Alexander Korchak on 20.05.2023.
//

import Foundation

extension Endpoint {
    
    var imageUrl: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "coinicons-api.vercel.app"
        components.path = "/api/icon/" + path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Wrong url components: \(components)")
        }
        
        return url
    }
}
