//
//  Coins.swift
//  CryptoSwiftUI
//
//  Created by Alexander Korchak on 20.05.2023.
//

import Foundation

struct Coins: Codable {
    var data: [Coin]
    let timestamp: Int?
}

// MARK: - Coin data

struct Coin: Codable, Identifiable, Hashable {
    let id: String
    let rank, symbol, name: String
    let supply, maxSupply, marketCapUsd, volumeUsd24Hr: String?
    let priceUsd, changePercent24Hr, vwap24Hr: String?
}

// MARK: - Extension with converted string values

extension Coin {
    
    var price: Double {
       Double(priceUsd ?? "0.0") ?? 0.0
    }
    
    var change24Hr: Double {
        Double(changePercent24Hr ?? "0.0") ?? 0.0
    }
    
    var marketCap: Double {
        Double(marketCapUsd ?? "") ?? 0.0
    }
    
    var coinSupply: Double {
        Double(supply ?? "") ?? 0.0
    }
    
    var volume24Hr: Double {
        Double(volumeUsd24Hr ?? "") ?? 0.0
    }
    
    var priceDifference: Double {
        (price * change24Hr) / 100
    }
    
    var convertedMarketCap: Double {
        marketCap / 1_000_000_000
    }
    
    var convertedSupply: Double {
        coinSupply / 1_000_000
    }
    
    var convertedVolume24Hr: Double {
        volume24Hr / 1_000_000_000
    }
}
