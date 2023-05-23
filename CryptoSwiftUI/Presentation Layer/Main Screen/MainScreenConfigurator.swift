//
//  MainScreenConfigurator.swift
//  CryptoSwiftUI
//
//  Created by Alexander Korchak on 20.05.2023.
//

import Foundation

final class MainScreenConfigurator {
    public static func configureMainScreenView(with viewModel: MainScreenViewModel = MainScreenViewModel()) -> MainScreenView {
        let mainScreenView = MainScreenView(viewModel: viewModel)
        return mainScreenView
        
    }
}
