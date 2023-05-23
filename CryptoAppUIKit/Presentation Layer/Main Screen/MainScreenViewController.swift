//
//  ViewController.swift
//  CryptoAppUIKit
//
//  Created by Alexander Korchak on 20.05.2023.
//

import UIKit
import SnapKit
import Combine

final class MainScreenViewController: UIViewController {
    
    let viewModel = MainScreenViewModel()
    var cancellables = Set<AnyCancellable>()
    
    lazy var table: UITableView =  {
        let table = UITableView(frame: .zero, style: .plain)
        table.backgroundColor = UIColor.theme.background
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.reuseIdentifier)
        return table
    }()
    
    private lazy var navigationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.theme.accent
        label.textAlignment = .left
        label.text = String(localized:  "Trending Сoins")
        label.font = UIFont(name: "SFPro-ExpandedSemibold", size: 24)
        return label
    }()
    
    lazy var searchBar: UISearchBar = {
          let search = UISearchBar()
          search.searchBarStyle = .minimal
        search.tintColor = UIColor.theme.accent
         
          return search
      }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.theme.background
        table.delegate = self
        table.dataSource = self
        setupContent()
        searchBar.delegate = self
        searchBar.sizeToFit()
        setupNavBar()
        showSearchBarButton(shouldShow: true)
        
        table.refreshControl = UIRefreshControl()
        table.refreshControl?.addTarget(self, action: #selector(pulled), for: .valueChanged)
      
        // getting data from pulisher initialised in viewModel
        viewModel.getData(keyword: searchBar.text!)
            self.viewModel.coins
                .receive(on: DispatchQueue.main)
                .sink { [weak self] _ in
                self?.table.reloadData()
            }
            .store(in: &self.cancellables)
    }
    
    private func setupContent() {
        view.addSubview(table)
        view.addSubview(navigationLabel)
        
        table.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(105)
            make.bottom.leading.trailing.equalToSuperview()
        }
        
        navigationLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.view.snp.leading).offset(20)
            make.top.equalTo(self.view.snp.top).offset(58)
            make.height.equalTo(32)
        }
    }
    
    private func setupNavBar() {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleSearchBar))
        }
    
    func showSearchBarButton(shouldShow: Bool) {
            if shouldShow {
                navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleSearchBar))
                navigationItem.rightBarButtonItem?.tintColor = UIColor.theme.accent
                navigationLabel.isHidden = false

            } else {
                navigationItem.rightBarButtonItem = nil
                navigationLabel.isHidden = true
            }
        }
        
        func search(shouldShow: Bool) {
            showSearchBarButton(shouldShow: !shouldShow)
            searchBar.showsCancelButton = shouldShow
            navigationItem.titleView = shouldShow ? searchBar : nil
            viewModel.getData(keyword: "")
        }
    
    @objc private func handleSearchBar() {
            search(shouldShow: true)
            searchBar.becomeFirstResponder()
        }
    
    @objc private func pulled() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.table.refreshControl?.endRefreshing()
        }
    }
}





