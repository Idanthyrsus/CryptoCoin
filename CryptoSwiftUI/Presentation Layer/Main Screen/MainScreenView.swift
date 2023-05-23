//
//  ContentView.swift
//  CryptoSwiftUI
//
//  Created by Alexander Korchak on 20.05.2023.
//

import SwiftUI

struct MainScreenView: View {
    
    @ObservedObject var viewModel: MainScreenViewModel
    
    init(viewModel: MainScreenViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            NavigationStack {
                allCoinsList
                    .onChange(of: viewModel.searchText, perform: { newValue in
                        viewModel.loadSearchResults()
                    })
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            ToolbarContent(viewModel: viewModel)
                        }
                    }
            }.navigationBarBackButtonHidden()
               
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView(viewModel: MainScreenViewModel())
    }
}

struct ToolbarContent: View {
    @ObservedObject var viewModel: MainScreenViewModel
    
    var body: some View {
        if viewModel.searchActive {
            HStack {
                SearchBarView(viewModel: viewModel)
                Button {
                    viewModel.searchActive.toggle()
                    viewModel.searchText = ""
                } label: {
                    Text("Cancel")
                }
            }
        } else {
            HStack {
                Text("Trending Сoins")
                    .font(Font.custom("SFPro-ExpandedSemibold", size: 24))
                Spacer()
                Button {
                    viewModel.searchActive.toggle()
                } label: {
                    Image(systemName: "magnifyingglass")
                }
            }
            .padding(.top)
        }
    }
}

extension MainScreenView {
    
    private var allCoinsList: some View {
        VStack {
            
            List {
                ForEach(viewModel.coins.data, id: \.self) { returnedCoin in
                    ZStack {
                        CoinRowView(coin: returnedCoin).onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                                viewModel.onItemAppear(item: returnedCoin)
                            }
                        }
                        
                        NavigationLink(destination: DetailScreenView(coin: returnedCoin),
                                       label: {
                            EmptyView()
                        }).frame(width: 0).opacity(0.0)
                    }
                }
                
            }.listStyle(PlainListStyle())
                .refreshable {
                    viewModel.onAppear()
                }.onAppear {
                        viewModel.loadMore()
                }
        }
    }
}

