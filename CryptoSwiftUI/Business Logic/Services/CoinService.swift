//
//  CoinService.swift
//  CryptoSwiftUI
//
//  Created by Alexander Korchak on 20.05.2023.
//

import Foundation
import Combine

protocol CoinServiceProtocol: AnyObject {
    var networkService: NetworkServiceProtocol { get }
    
    func getCoins(count: Int) -> AnyPublisher<Coins, Error>
    func getCoins(keyword: String?, count: Int, offset: Int) -> AnyPublisher<Coins, Error>
}

final class CoinService: CoinServiceProtocol {
    
    var networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func getCoins(count: Int) -> AnyPublisher<Coins, Error> {
        
        let endpoint = Endpoint.coins(count: count)
        return networkService.get(type: Coins.self, url: endpoint.url)
    }
    
    func getCoins(keyword: String?, count: Int, offset: Int) -> AnyPublisher<Coins, Error> {
        let endpoint = Endpoint.coins(keyword: keyword, count: count, offset: offset)
        return networkService.get(type: Coins.self, url: endpoint.url)
    }
}
