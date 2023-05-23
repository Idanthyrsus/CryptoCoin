//
//  ImageService.swift
//  CryptoSwiftUI
//
//  Created by Alexander Korchak on 20.05.2023.
//


import Foundation
import Combine

protocol ImageServiceProtocol: AnyObject {
    var networkService: NetworkServiceProtocol { get }
    
    func getImages(symbol: String) -> AnyPublisher<Data, URLError>
}

final class ImageService: ImageServiceProtocol {
    var networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func getImages(symbol: String) -> AnyPublisher<Data, URLError> {
        
        let endpoint = Endpoint.images(symbol: symbol)
        return networkService.getData(url: endpoint.imageUrl)
    }
}
