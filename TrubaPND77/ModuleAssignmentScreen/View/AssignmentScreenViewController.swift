//
//  AssignmentViewController.swift
//  TrubaPND77
//
//  Created by Serg on 19.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit

class AssignmentScreenViewController: UICollectionViewController {
    
    private let viewModel: ViewModelAssignmentScreenProtocol
    private let router: AssignmentScreenRouterInput
    
    private weak var indicatorView: UIActivityIndicatorView!
    private let padding: CGFloat = 16
    
    init(viewModel: ViewModelAssignmentScreenProtocol, router: AssignmentScreenRouterInput, layout: UICollectionViewLayout) {
        self.viewModel = viewModel
        self.router = router
        super.init(collectionViewLayout: layout)
}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        settingLayoutCollectionView()
        
        viewModel.state.bind { [weak self] (state) in
            guard let self = self else {
                print("AssignmentScreenViewController is deinitialized")
                return
            }
            
            switch state {
            case .initial:
                return
            case .showLoader:
                self.showLoader()
            case .readyToShowItems:
                self.cancelLoader()
                self.collectionView.reloadData()
            case .errorOccured(let error):
                self.cancelLoader()
                self.showInfoAlert(description: error)
            }
        }
        getListOfItems()
    }
    
    fileprivate func settingLayoutCollectionView() {
        let indicator: UIActivityIndicatorView
        if #available(iOS 13.0, *) {
            collectionView.backgroundColor = .secondarySystemBackground
            indicator = UIActivityIndicatorView(style: .large)
        } else {
            collectionView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
            indicator = UIActivityIndicatorView(style: .gray)
        }
        
        collectionView.register(AssignmentScreenCollectionViewCell.self, forCellWithReuseIdentifier: AssignmentScreenCollectionViewCell.reuseIdentifier)
        
        self.indicatorView = indicator
        collectionView.addSubview(indicatorView)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            collectionView.centerYAnchor.constraint(equalTo: indicatorView.centerYAnchor, constant: 70)
        ])
    }
    
    private func showLoader() {
        indicatorView.startAnimating()
    }
    
    private func cancelLoader() {
        indicatorView.stopAnimating()
    }
    
    private func getListOfItems() {
        viewModel.getInformation()
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
    
    //MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AssignmentScreenCollectionViewCell.reuseIdentifier, for: indexPath) as? AssignmentScreenCollectionViewCell else {
            return UICollectionViewCell()
        }
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        cell.viewModel = cellViewModel
        
        return cell
    }
    
    //MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = viewModel.getCredentialFor(item: indexPath)
        router.transitionToProductScreen(with: data)
    }
}

extension AssignmentScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let inset: CGFloat = 10
        let width = self.collectionView.frame.width - 2*padding
        let height: CGFloat = 200

        if traitCollection.horizontalSizeClass == .regular {
            return .init(width: (width - 3*inset)/4, height: height + 50)
        }
        return .init(width: (width - inset)/2, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: padding, left: padding, bottom: padding, right: padding)
    }
}
