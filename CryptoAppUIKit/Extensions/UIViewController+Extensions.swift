
import Foundation
import UIKit

// All methods assossiated with UITableView are located here
extension MainScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.coins.value.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.reuseIdentifier, for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        
        let newViewModel = viewModel.coins.value.data[indexPath.row]
        let imageViewModel = CoinImageViewModel(coin: newViewModel)
        imageViewModel.onAppear()
        
        cell.configureCell(using: newViewModel)
    
        imageViewModel.image.sink { receivedImage in
            cell.coinImageView.image = receivedImage
        }
        .store(in: &cancellables)
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.viewModel.willDisplay(itemAtIndex: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newViewModel = viewModel.coins.value.data[indexPath.row]
        let viewController = DetailViewController()
        viewController.navigationLabel.text = newViewModel.name
        viewController.priceLabel.text = "$ \(newViewModel.price.asCurrencyWith2Decimals())"
        viewController.marketCapNumberLabel.text = "$\(newViewModel.convertedMarketCap.asCurrencyWith2Decimals())b"
        viewController.percentLabel.text = "\(newViewModel.priceDifference.asCurrencyWith2Decimals()) (\(newViewModel.change24Hr.asPercentString()))"
        viewController.supplyNumberLabel.text = "\(newViewModel.convertedSupply.asCurrencyWith2Decimals())m"
        viewController.volume24HrValueLabel.text = "$\(newViewModel.convertedVolume24Hr.asCurrencyWith2Decimals())m"
        
        if newViewModel.change24Hr < 0 {
            viewController.percentLabel.textColor = UIColor.theme.red
        } else {
            viewController.percentLabel.textColor = UIColor.theme.green
            viewController.percentLabel.text = "+\(newViewModel.priceDifference.asCurrencyWith2Decimals()) (\(newViewModel.change24Hr.asPercentString()))"
        }

        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// UISearchBar methods
extension MainScreenViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(shouldShow: false)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.getData(keyword: searchBar.text!)
        viewModel.coins.sink { [weak self] _ in
            guard let self = self else {
                return
            }
            self.table.reloadData()
        }
        .store(in: &cancellables)
    }
}
