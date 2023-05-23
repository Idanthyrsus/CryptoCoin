//
//  Endpoint+Coins.swift
//  CryptoSwiftUI
//
//  Created by Alexander Korchak on 20.05.2023.
//

import Foundation

extension Endpoint {
    static var coins: Self {
        return Endpoint(path: "/assets")
    }
    
    static func coins(count: Int) -> Self {
        return Endpoint(path: "/assets", queryItems: [
            URLQueryItem(name: "limit",
                         value: "\(count)")
        ])
    }
    
    static func coins(count: Int, offset: Int) -> Self {
        return  Endpoint(path: "/assets", queryItems: [
            URLQueryItem(name: "limit",
                         value: "\(count)"),
            URLQueryItem(name: "offset",
                         value: "\(offset)")
            
        ])
    }
    
    static func coins(keyword: String, count: Int) -> Self {
        return  Endpoint(path: "/assets", queryItems: [
            URLQueryItem(name: "search",
                         value: "\(keyword)"),
            URLQueryItem(name: "limit",
                         value: "\(count)")
            
        ])
    }
}
