//
//  CoinRowView.swift
//  CryptoSwiftUI
//
//  Created by Alexander Korchak on 20.05.2023.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: Coin
    
    var body: some View {
        HStack(spacing: 0) {
            leftColumn
            Spacer()
            rightColumn
        }
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: Coin.mock())
    }
}

extension CoinRowView {
    private var leftColumn: some View {
        HStack {
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            VStack(alignment: .leading, spacing: 0) {
                Text(coin.name)
                
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(Color.theme.accent)
                Text(coin.symbol)
                    .font(.system(size: 14, weight: .regular))
                    .opacity(0.5)
                    .foregroundColor(Color.theme.secondaryText)
            }
            
            .font(.headline)
        }
    }
    
    private var rightColumn: some View {
        VStack(alignment: .trailing) {
            
            Text("\(coin.price.asCurrencyWith2Decimals())")
                .font(.system(size: 16, weight: .regular))
            Text( coin.change24Hr > 0 ?
                  "+\(coin.change24Hr.asPercentString())"
                  :  "\(coin.change24Hr.asPercentString())"
                )
            .font(.system(size: 14, weight: .regular))
                .foregroundColor(coin.change24Hr >= 0 ? Color.theme.green : Color.theme.red)
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}
