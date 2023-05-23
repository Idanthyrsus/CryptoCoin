//
//  ImageService.swift
//  CryptoSwiftUI
//
//  Created by Alexander Korchak on 20.05.2023.
//

import Foundation

protocol ImageServiceProtocol: AnyObject {
    var networkService: NetworkServiceProtocol { get }
    
    func getImages(symbol: String) async -> Data
}

final class ImageService: ImageServiceProtocol {
    var networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    /// Asynchronous function which retrieves data to display image
    /// - Parameter symbol: coin symbol from coin json which is used for building url to get a particular coin image
    /// - Returns: type Data which later  is used in UIImage(data: )
    func getImages(symbol: String) async -> Data {
        
        let endpoint = Endpoint.images(symbol: symbol)
        do {
           let result = try await networkService.getData(url: endpoint.imageUrl)
            return result
        } catch let error {
            print(error)
            return Data()
        }
    }
}
