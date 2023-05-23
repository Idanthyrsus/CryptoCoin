//
//  MainScreenViewModel.swift
//  CryptoSwiftUI
//
//  Created by Alexander Korchak on 20.05.2023.
//

import Foundation
import Combine

protocol MainScreenViewModelProtocol: AnyObject {
    func getData(keyword: String)
    func pageDidLoad(data: Coins)
    func willDisplay(itemAtIndex index: Int)
    func requestNewPage()
}

final class MainScreenViewModel: ObservableObject {
    
    private enum Constansts {
        static let pageItemsLimit = 10
    }
    
    private var offset = 0
    private var isNeedToRequestMore = true
    
    var elements: Coins = Coins(data: [], timestamp: nil)
    var coins = CurrentValueSubject<Coins, Never>(Coins(data: [], timestamp: nil))
    
    private var searchKeyword: String = ""
    private var maxRequestedIndex: Int = -1
    private var isLoading: Bool = false
    private var newPageShouldBeRequested: Bool = false
    private var cancellables = Set<AnyCancellable>()
    private var coinService: CoinServiceProtocol
    
    
    init(coins: CurrentValueSubject<Coins, Never> = CurrentValueSubject<Coins, Never>(Coins(data: [], timestamp: nil)),
         coinService: CoinServiceProtocol = CoinService()) {
        self.coins = coins
        self.coinService = coinService
    }
    
    func getData(keyword: String) {
        do {
            if self.searchKeyword != keyword {
                isNeedToRequestMore = true
                elements.data = []
                maxRequestedIndex = -1
                newPageShouldBeRequested = false
                offset = 0
                cancellables.forEach { $0.cancel() }
            }
            self.searchKeyword = keyword
            if isNeedToRequestMore {
                let returnedData = try coinService.fetchData(by: self.searchKeyword, limit: Constansts.pageItemsLimit, offset: offset)
                returnedData
                    .subscribe(on: DispatchQueue.global(qos: .background))
                    .receive(on: DispatchQueue.main)
                    .map { coinElement -> Coins in
                        self.pageDidLoad(data: coinElement)
                        return coinElement
                    }
                    .replaceError(with: Coins(data: [], timestamp: nil))
                    .sink { [weak self] coin in
                        guard let self = self else {
                            return
                        }
                        self.elements.data.append(contentsOf: coin.data)
                        self.coins.send(self.elements)
                    }
                    .store(in: &cancellables)
            }
        } catch let error  {
            print("Error \(error)")
        }
    }
    
    func pageDidLoad(data: Coins) {
        if data.data.isEmpty {
            self.isNeedToRequestMore = false
        }
        self.isLoading = false
        self.offset = coins.value.data.count
        
        if newPageShouldBeRequested {
            requestNewPage()
        }
    }
    
    func willDisplay(itemAtIndex index: Int) {
    
        guard index + Constansts.pageItemsLimit > maxRequestedIndex else {
            newPageShouldBeRequested = false
            return
        }
        
        guard isLoading == false else {
            newPageShouldBeRequested = true
            return
        }
        requestNewPage()
    }
    
    func requestNewPage() {
        isLoading = true
        maxRequestedIndex = elements.data.count + Constansts.pageItemsLimit
        getData(keyword: searchKeyword)
    }
}
