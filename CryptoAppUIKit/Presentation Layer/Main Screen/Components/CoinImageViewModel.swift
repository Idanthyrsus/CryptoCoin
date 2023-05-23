//
//  CoinImageViewModel.swift
//  CryptoSwiftUI
//
//  Created by Alexander Korchak on 20.05.2023.
//

import Foundation
import Combine
import UIKit

final class CoinImageViewModel: ObservableObject {

    var image = CurrentValueSubject<UIImage?, Never>(nil)
    
    private var cancellables = Set<AnyCancellable>()
    
    private let coin: Coin
    private let viewModel = MainScreenViewModel()
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
        
        Task {
            let result = await dataService.getImages(symbol: symbol.lowercased())
            await MainActor.run(body: {
                if let image = UIImage(data: result) {
                    self.image.send(image)
                }
            })
        }
    }
}
