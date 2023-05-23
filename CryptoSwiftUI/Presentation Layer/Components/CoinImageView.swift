//
//  CoinImageView.swift
//  CryptoSwiftUI
//
//  Created by Alexander Korchak on 20.05.2023.
//

import SwiftUI

struct CoinImageView: View {

    @StateObject var viewModel: CoinImageViewModel
    
    init(coin: Coin) {
        _viewModel = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(Color.gray)
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: Coin.mock())
    }
}
