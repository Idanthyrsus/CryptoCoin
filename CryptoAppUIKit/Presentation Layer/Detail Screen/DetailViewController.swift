//
//  DetailViewController.swift
//  CryptoAppUIKit
//
//  Created by Alexander Korchak on 21.05.2023.
//

import UIKit
import SnapKit

final class DetailViewController: UIViewController {
    
     lazy var navigationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.theme.accent
        label.textAlignment = .left
        label.font = UIFont(name: "SFPro-ExpandedSemibold", size: 24)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "SFPro-Regular", size: 24)
        return label
    }()
    
    lazy var percentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "SFPro-Regular", size: 14)
        return label
    }()
    lazy var marketCapLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = String(localized: "Market Cap")
        label.textColor = .lightGray
        label.font = UIFont(name: "SFPro-Regular", size: 12)
        return label
    }()
    lazy var marketCapNumberLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    lazy var supplyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = String(localized: "Supply")
        label.textColor = .lightGray
        label.font = UIFont(name: "SFPro-Regular", size: 12)
        return label
    }()
    lazy var supplyNumberLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "SFPro-Regular", size: 16)
        return label
    }()
    lazy var volume24HrLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = String(localized: "Volume 24Hr")
        label.textColor = .lightGray
        label.font = UIFont(name: "SFPro-Regular", size: 12)
        return label
    }()
    lazy var volume24HrValueLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "SFPro-Regular", size: 16)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.theme.background
        setupElements()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(goToMainViewController))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.theme.accent
    }
    
    @objc func goToMainViewController() {
            self.navigationController?.popViewController(animated: true)
        }
    
    
   // MARK: - setting up UI elements
    
    func setupElements() {
        view.addSubviews([
            navigationLabel,
            priceLabel,
            percentLabel,
            marketCapLabel,
            marketCapNumberLabel,
            supplyLabel, supplyNumberLabel,
            volume24HrLabel,
            volume24HrValueLabel
        ])
        
        navigationLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.view.snp.leading).offset(70)
            make.top.equalTo(self.view.snp.top).offset(40)
            make.width.equalTo(300)
            make.height.equalTo(60)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.top.equalTo(view.snp.top).offset(130)
            make.height.equalTo(29)
        }
        percentLabel.snp.makeConstraints { make in
            make.leading.equalTo(priceLabel.snp.trailing).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-99)
            make.top.equalTo(view.snp.top).offset(136)
            make.height.equalTo(17)
        }
        marketCapLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.top.equalTo(priceLabel.snp.bottom).offset(24)
            make.width.equalTo(90)
            make.height.equalTo(30)
        }
        supplyLabel.snp.makeConstraints { make in
            make.leading.equalTo(marketCapLabel.snp.trailing).offset(54)
            make.top.equalTo(priceLabel.snp.bottom).offset(24)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        volume24HrLabel.snp.makeConstraints { make in
            make.leading.equalTo(supplyLabel.snp.trailing).offset(50)
            make.top.equalTo(priceLabel.snp.bottom).offset(24)
            make.width.equalTo(90)
            make.height.equalTo(30)
        }
        marketCapNumberLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.top.equalTo(marketCapLabel.snp.bottom).offset(2)
            make.height.equalTo(19)
        }
        supplyNumberLabel.snp.makeConstraints { make in
            make.leading.equalTo(marketCapNumberLabel.snp.trailing).offset(70.5)
            make.top.equalTo(supplyLabel.snp.bottom).offset(2)
            make.width.equalTo(100)
            make.height.equalTo(19)
        }
        volume24HrValueLabel.snp.makeConstraints { make in
            make.leading.equalTo(supplyNumberLabel.snp.trailing).offset(45)
            make.top.equalTo(volume24HrLabel.snp.bottom).offset(2)
            make.width.equalTo(60)
            make.height.equalTo(19)
        }
    }
}
