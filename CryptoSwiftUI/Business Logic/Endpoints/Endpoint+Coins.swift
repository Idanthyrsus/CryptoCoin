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
    
    static func coins(keyword: String?, count: Int, offset: Int) -> Self {
        var queryItems = [URLQueryItem(name: "limit",
                                       value: "\(count)"),
                          URLQueryItem(name: "offset",
                                       value: "\(offset)")]
        if let keyword, !keyword.isEmpty {
            let searchItem = URLQueryItem(name: "search", value: "\(keyword)")
            queryItems.append(searchItem)
        }

        return  Endpoint(path: "/assets", queryItems: queryItems)
    }
}
