//
//  CoinImageViewModel.swift
//  CryptoSwiftUI
//
//  Created by Alexander Korchak on 20.05.2023.
//

import Foundation
import Combine
import SwiftUI

class CoinImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    private var cancellables = Set<AnyCancellable>()
    
    private let coin: Coin
    private let dataService: ImageServiceProtocol
    
    init(coin: Coin, dataService: ImageServiceProtocol = ImageService()) {
        self.dataService = dataService
        self.coin = coin
    }
    
    public func onAppear() {
        getImages()
    }
    
    private func getImages() {
        let symbol = coin.symbol
        
        dataService.getImages(symbol: symbol.lowercased())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [weak self] returnedData in
                guard let self = self,
                      let image = UIImage(data: returnedData) else {
                    return
                }
                self.image = image
            }
            .store(in: &cancellables)
    }
}
