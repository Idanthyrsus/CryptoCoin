//
//  CustomTableViewCell.swift
//  CryptoAppUIKit
//
//  Created by Alexander Korchak on 21.05.2023.
//

import UIKit
import SnapKit

final class CustomTableViewCell: UITableViewCell {
    
     lazy var coinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var coinLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = UIFont(name: "SFPro-Regular", size: 16)
        return label
    }()
    
    private lazy var symbolLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = UIFont(name: "SFPro-Regular", size: 14)
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private lazy var percentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        coinImageView.image = nil
        coinLabel.text = ""
        symbolLabel.text = ""
        priceLabel.text = ""
        percentLabel.text = ""
    }
    
    private func setupSubviews() {
        addSubviews([
            coinImageView,
            coinLabel,
            symbolLabel,
            priceLabel,
            percentLabel
        ])
            coinImageView.snp.makeConstraints { make in
                make.leading.equalTo(self.contentView.snp.leading).offset(16)
                make.top.equalTo(11)
                make.height.width.equalTo(48)
            }
            coinLabel.snp.makeConstraints { make in
                make.top.equalTo(14)
                make.leading.equalTo(self.coinImageView.snp.trailing).offset(10)
                make.trailing.equalTo(self.contentView.snp.trailing).offset(-100)
                make.height.equalTo(19)
            }
            symbolLabel.snp.makeConstraints { make in
                make.top.equalTo(self.coinLabel.snp.bottom).offset(2)
                make.leading.equalTo(self.coinImageView.snp.trailing).offset(10)
                make.trailing.equalTo(self.contentView.snp.trailing).offset(-240)
                make.height.equalTo(19)

            }
            priceLabel.snp.makeConstraints { make in
                make.top.equalTo(14)
                make.trailing.equalTo(self.contentView.snp.trailing).offset(-16)
                make.leading.equalTo(self.contentView.snp.leading).offset(255)
                make.height.equalTo(19)
            }
            percentLabel.snp.makeConstraints { make in
                make.top.equalTo(self.priceLabel.snp.bottom).offset(2)
                make.trailing.equalTo(self.contentView.snp.trailing).offset(-16)
                make.leading.equalTo(self.contentView.snp.leading).offset(290)
                make.height.equalTo(19)
            }
        }
    
    func configureCell(using model: Coin) {
        self.coinLabel.text = model.name
        self.symbolLabel.text = model.symbol
        self.priceLabel.text = "$ \(model.price.asCurrencyWith2Decimals())"
        self.percentLabel.text = "\(model.change24Hr.asPercentString())"
        
        if model.change24Hr > 0 {
            self.percentLabel.text = "+\(model.change24Hr.asPercentString())"
            self.percentLabel.textColor = UIColor.theme.green
        } else {
            self.percentLabel.textColor = UIColor.theme.red
        }
    }
}
