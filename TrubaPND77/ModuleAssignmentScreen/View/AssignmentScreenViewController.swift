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
                print("AssignmentScreenViewController deinited")
                return
            }
            
            switch state {
            case .initial:
                return
            case .showLoader:
                self.showLoader()
            case .readyToShowItems:
                self.collectionView.reloadData()
                self.cancelLoader()
            case .errorOccured(let error):
                self.cancelLoader()
                self.showError(description: error)
            }
        }
        getListOfItems()
    }
    
    fileprivate func settingLayoutCollectionView() {
        if #available(iOS 13.0, *) {
            collectionView.backgroundColor = .secondarySystemBackground
        } else {
            collectionView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        }
        collectionView.register(AssignmentScreenCollectionViewCell.self, forCellWithReuseIdentifier: AssignmentScreenCollectionViewCell.reuseIdentifier)
        
        let refreshControl = UIRefreshControl()
        collectionView.refreshControl = refreshControl
    }
    
    private func showLoader() {
        collectionView.refreshControl?.beginRefreshing()
    }
    
    private func cancelLoader() {
        collectionView.refreshControl?.endRefreshing()
        //MARK: !!!!!?????? in terminal appear a message
        collectionView.refreshControl = nil
    }
    
    private func getListOfItems() {
        viewModel.getInformation()
    }
    
    private func showError(description: String) {
        settingAlert(title: "Error", message: description)
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
        router.transitionToProductScreen()
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
