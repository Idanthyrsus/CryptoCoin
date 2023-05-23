//
//  SearchBarView.swift
//  CryptoSwiftUI
//
//  Created by Alexander Korchak on 21.05.2023.
//

import SwiftUI

struct SearchBarView: View {
    
    @ObservedObject var viewModel: MainScreenViewModel
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search by name or symbol", text: $viewModel.searchText)
        }
        .frame(height: 8)
        .font(Font.custom("SFPro-Regular", size: 14))
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.theme.background)
                .shadow(color: Color.black.opacity(0.3),
                    radius: 2,
                    x: 0,
                    y: 0))
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(viewModel: MainScreenViewModel())
    }
}
