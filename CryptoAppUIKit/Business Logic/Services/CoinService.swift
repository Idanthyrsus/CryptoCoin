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
 
    func fetchData(by keyword: String, limit: Int, offset: Int) throws -> AnyPublisher<Coins, Error> 
}

/// Class responsible for network call which fetches all coins data
final class CoinService: CoinServiceProtocol {
    
    var networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    /// Function responsible for network call with pagination
    /// - Parameters:
    ///   - keyword: SearchBar text
    ///   - limit: Number of elements displayed at one API call
    ///   - offset: Index of the last element displayed
    /// - Returns: Publisher with array of Coin
    func fetchData(by keyword: String, limit: Int = 20, offset: Int = 0) throws -> AnyPublisher<Coins, Error>  {
        
        return try networkService.fetchData(by: keyword, limit: limit, offset: offset)
    }
}
