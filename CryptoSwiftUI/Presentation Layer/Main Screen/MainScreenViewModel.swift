//
//  MainScreenViewModel.swift
//  CryptoSwiftUI
//
//  Created by Alexander Korchak on 20.05.2023.
//

import Foundation
import Combine

class MainScreenViewModel: ObservableObject {
    @Published public var coins: Coins = Coins(data: [], timestamp: nil)
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    @Published var searchActive = false
    
    private var cancellables = Set<AnyCancellable>()
    private var coinService: CoinServiceProtocol
    private var newPageShouldBeRequested: Bool = false
    private var isNeedToRequestMore = true



    let limit: Int  = 10
    var offset: Int = 0

    private var maxRequestedIndex: Int = -1
    private var currentSearch: String? = ""

    private let operationQueue: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 1
        operationQueue.qualityOfService = QualityOfService.utility
        return operationQueue
    }()

    init(coins: Coins = Coins(data: [], timestamp: nil),
         coinService: CoinServiceProtocol = CoinService()) {
        self.coins = coins
        self.coinService = coinService
        
        $searchText
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] keyword in
                guard let self = self else {
                    return
                }
                self.getCoins(by: keyword, count: self.limit)
            }
            .store(in: &cancellables)
    }
    
    public func onAppear() {
        getCoins(by: nil, count: limit)
    }
    
    public func loadMore() {
        getCoins(by: searchText, count: limit)
    }
    
    public func loadSearchResults() {
        getCoins(by: searchText, count: limit)
    }

    public func onItemAppear(item: Coin) {
        guard let index = coins.data.firstIndex(of: item) else {
            return
        }
        willDisplay(itemAtIndex: index)
    }
    
    private func getCoins(by keyword: String?, count: Int) {
        if self.currentSearch != keyword {
            isNeedToRequestMore = true
            coins.data = []
            maxRequestedIndex = -1
            newPageShouldBeRequested = false
            offset = 0
            cancellables.forEach { $0.cancel() }
            operationQueue.cancelAllOperations()
        }
        self.currentSearch = keyword

        operationQueue.addOperation { [weak self] in
            guard let self = self else {
                return
            }
            self.coinService.getCoins(keyword: keyword, count: count, offset: self.offset)
                .receive(on: DispatchQueue.main)
                .sink {
                    completion in
                    switch completion {
                    case .failure(let error):
                        print(error)
                    case .finished:
                        break
                    }

                } receiveValue: {
                    [weak self] receivedCoins in
                    guard let self = self else {
                        return
                    }
                    self.pageDidLoad(data: receivedCoins)
                }
                .store(in: &self.cancellables)
        }
    }

    private func pageDidLoad(data: Coins) {
        self.coins.data.append(contentsOf: data.data)
        self.isLoading = false
        self.offset = self.coins.data.count
        if newPageShouldBeRequested {
            requestNewPage()
        }
    }

    private func willDisplay(itemAtIndex index: Int) {

        guard index + limit > maxRequestedIndex else {
            newPageShouldBeRequested = false
            return
        }

        guard isLoading == false else {
            newPageShouldBeRequested = true
            return
        }

        requestNewPage()
    }

    private func requestNewPage() {
        isLoading = true
        maxRequestedIndex = coins.data.count + limit
        getCoins(by: searchText, count: limit)
    }
}
