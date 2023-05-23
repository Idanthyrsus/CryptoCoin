//
//  NetworkService.swift
//  CryptoSwiftUI
//
//  Created by Alexander Korchak on 20.05.2023.
//

import Foundation
import Combine

protocol NetworkServiceProtocol: AnyObject {
    typealias Headers = [String: Any]
    
    func get<T>(type: T.Type, url: URL) -> AnyPublisher<T, Error> where T : Decodable
    
    func getData(url: URL) -> AnyPublisher<Data, URLError>
}

final class NetworkService: NetworkServiceProtocol {
    
    func get<T>(type: T.Type, url: URL) -> AnyPublisher<T, Error> where T : Decodable {
        let urlRequest = URLRequest(url: url)
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func getData(url: URL) -> AnyPublisher<Data, URLError> {
        let urlRequest = URLRequest(url: url)
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .eraseToAnyPublisher()
    }
}
