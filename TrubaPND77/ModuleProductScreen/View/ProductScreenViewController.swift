//
//  NewVC.swift
//  TrubaPND77
//
//  Created by Serg on 21.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit

class ProductScreenViewController: UITableViewController {
    
    private let viewModel: ViewModelProductScreenProtocol
    private let router: ProductScreenRouterInput
    
    private weak var footerView: FooterIndicatorableProtocol!
    
    init(viewModel: ViewModelProductScreenProtocol, router: ProductScreenRouterInput) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingLayoutCollectionView()
        registerCells()
        
        viewModel.state.bind { [weak self] (state) in
            guard let self = self else {
                print("ProductScreenViewController is deinitialized")
                return
            }
            
            switch state {
            case .initial:
                return
            case .showLoader:
                self.showLoader()
            case .readyToShowItems:
                self.tableView.reloadData()
                self.cancelLoader()
            case .errorOccured(let error):
                self.cancelLoader()
                self.showInfoAlert(description: error)
            }
        }
        getInformationOfProduct()
    }
    
    private func getInformationOfProduct() {
        viewModel.getInformation()
    }
    
    fileprivate func settingLayoutCollectionView() {
        if #available(iOS 13.0, *) {
            tableView.backgroundColor = .systemBackground
        } else {
            tableView.backgroundColor = .white
        }
        
        let footer = FooterViewProductScreen()
        footer.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40)
        self.footerView = footer
        tableView.tableFooterView = footer
        tableView.allowsSelection = false
        tableView.separatorInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    private func registerCells() {
        let nibCredential = UINib(nibName: CredentialProductCell.reuseIdentifier, bundle:  Bundle(for: CredentialProductCell.self))
        tableView.register(nibCredential, forCellReuseIdentifier: CredentialProductCell.reuseIdentifier)
        
        let nibCharacter = UINib(nibName: CharacteristicsProductCell.reuseIdentifier, bundle: Bundle(for: CharacteristicsProductCell.self))
        tableView.register(nibCharacter, forCellReuseIdentifier: CharacteristicsProductCell.reuseIdentifier)
        
        let nibAbout = UINib(nibName: AboutProductCell.reuseIdentifier, bundle: Bundle(for: AboutProductCell.self))
        tableView.register(nibAbout, forCellReuseIdentifier: AboutProductCell.reuseIdentifier)
    }
    
    private func showLoader() {
        footerView.startAnimating()
    }
    
    private func cancelLoader() {
        footerView.stopAnimating()
    }
    
    private func showInfoAlert(description: String) {
        settingAlert(title: "Информация", message: description)
    }
    
    private func settingAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK: ordering
    @objc private func orderButtonIsPressed() {
        router.transitionToOrderScreen()
    }
    
    //MARK: UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath),
            let cell = tableView.dequeueReusableCell(withIdentifier: cellViewModel.reuseIdentifier, for: indexPath) as? ProductScreenCellProtocol else {
                objectDescription(self, function: #function)
                return UITableViewCell()
        }
        cell.viewModel = cellViewModel
        return cell
    }
}
