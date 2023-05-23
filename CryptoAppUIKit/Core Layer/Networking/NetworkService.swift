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
    
    func fetchData<T>(by keyword: String, limit: Int, offset: Int) throws -> AnyPublisher<T, Error> where T: Decodable
    
    func getData(url: URL) async throws -> Data
}

/// This is the main class responsible for all network calls in the app
final class NetworkService: NetworkServiceProtocol {
    
    /// Generic function used for making an API call
    /// - Parameters:
    ///   - keyword: String used to build url with query item 'search'
    ///   - limit: Number of items displayed at one API call
    ///   - offset: Index of the last element displayed
    /// - Returns: Publisher with generic decodable type
    func fetchData<T>(by keyword: String, limit: Int, offset: Int) throws -> AnyPublisher<T, Error> where T: Decodable {
        let urlString = Endpoint.baseUrl
        
        guard var url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var items = [URLQueryItem]()
        let limitItem = URLQueryItem(name: "limit", value: "\(limit)")
        if !keyword.isEmpty {
            let keywordItem = URLQueryItem(name: "search", value: keyword)
            items.append(keywordItem)
        }
        items.append(limitItem)

        if offset > 0 {
            let offsetItem = URLQueryItem(name: "offset", value: "\(offset)")
            items.append(offsetItem)
        }
        url.append(queryItems: items)
     
        return URLSession.shared.dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    /// Asynchronous function which retrieves data to display image
    /// - Parameter url: image url
    /// - Returns: type Data which later  is used in UIImage(data: )
    func getData(url: URL) async throws -> Data {
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return data
    }
}
