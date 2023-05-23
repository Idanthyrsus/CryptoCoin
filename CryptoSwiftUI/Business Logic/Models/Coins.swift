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

// MARK: - DataClass
struct Coin: Codable, Identifiable, Hashable {
    let id: String
    let rank, symbol, name: String
    let supply, maxSupply, marketCapUsd, volumeUsd24Hr: String?
    let priceUsd, changePercent24Hr, vwap24Hr: String?
}

extension Coin {
    static func mock() -> Self {
        return Coin(id: "bitcoin",
                    rank: "1",
                    symbol: "BTC",
                    name: "Bitcoin",
                    supply: "17193925.0000000000000000",
                    maxSupply: "21000000.0000000000000000",
                    marketCapUsd: "119179791817.6740161068269075",
                    volumeUsd24Hr: "2928356777.6066665425687196",
                    priceUsd: "6931.5058555666618359",
                    changePercent24Hr: "-0.8101417214350335",
                    vwap24Hr: "7175.0663247679233209")
    }
}

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
