//
//  DetailScreenView.swift
//  CryptoSwiftUI
//
//  Created by Alexander Korchak on 21.05.2023.
//

import SwiftUI

struct DetailScreenView: View {
    
    let coin: Coin
    let viewModel = MainScreenViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    init(coin: Coin) {
        self.coin = coin
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    .padding(.leading)
                    .padding(.top)
                    .font(.headline)
                    Text(coin.name)
                        .font(Font.custom("SFPro-ExpandedSemibold", size: 24))
                        .padding(.top)
                        .offset(x: 30)
                }
                
                HStack(spacing: 10) {
                    Text("$ \(coin.price.asCurrencyWith2Decimals())")
                        .padding()
                        .font(Font.custom("SFPro-Regular", size: 24))
                    Text(
                        coin.change24Hr > 0 ?
                        "+\(coin.priceDifference.asCurrencyWith2Decimals()) (\(coin.change24Hr.asPercentString()))" :  "\(coin.priceDifference.asCurrencyWith2Decimals()) (\(coin.change24Hr.asPercentString()))"
                    )
                    .font(Font.custom("SFPro-Regular", size: 14))
                    .foregroundColor(coin.change24Hr < 0 ? Color.theme.red : Color.theme.green)
                    
                }
                
                .foregroundColor(Color.theme.accent)
                Spacer()
                
                HStack(spacing: 50) {
                    Text("Market Cap")
                        .frame(width: 90, height: 30, alignment: .leading)
                    Text("Supply")
                        .frame(width: 90, height: 30, alignment: .leading)
                    Text("Volume 24Hr")
                        .frame(width: 90, height: 30, alignment: .leading)
                }
                
                .font(Font.custom("SFPro-Regular", size: 12))
                .foregroundColor(Color.theme.secondaryText)
                .padding(.horizontal)
                Spacer()
                
                
                HStack(spacing: 50) {
                    Text("$\(coin.convertedMarketCap.asCurrencyWith2Decimals())b")
                        .frame(width: 90, height: 30, alignment: .leading)
                    Text("\(coin.convertedSupply.asNumberString())m")
                        .frame(width: 90, height: 30, alignment: .leading)
                    Text("$\(coin.convertedVolume24Hr.asNumberString())b")
                        .frame(width: 90, height: 30, alignment: .leading)
//                        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
                    
                }
                .padding(.horizontal)
                .font(Font.custom("SFPro-Regular", size: 16))
                Spacer()
                    .foregroundColor(Color.theme.secondaryText)
                    .padding(.horizontal)
            }
        }
        .navigationBarBackButtonHidden()
        
        Spacer()
    }
}

struct DetailScreenView_Previews: PreviewProvider {
    static var previews: some View {
        DetailScreenView(coin: Coin.mock())
    }
}
