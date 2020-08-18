//
//  ViewController.swift
//  TrubaPND77
//
//  Created by Serg on 28.07.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import UIKit

class MainScreenViewController: UICollectionViewController {
    
    private let viewModel: ViewModelMainScreenProtocol
    //MARK: for blur effect
    private weak var animatedView: AnimatedViewMainScreenInterface!
    private let padding: CGFloat = 16
    
    init(viewModel: ViewModelMainScreenProtocol, layout: UICollectionViewLayout) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingLayoutCollectionView()
        viewModel.state.bind { [weak self] (state) in
            guard let self = self else {
                print("MainScreenViewController deinited")
                return
            }
            
            switch state {
            case .initial:
                return
            case .readyToShowItems:
                self.collectionView.reloadData()
            case .errorOccure(let unknownError):
                self.showError(description: unknownError)
            }
        }
        viewModel.generateItems()
    }
    
    private func settingLayoutCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.showsVerticalScrollIndicator = false
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = .init(top: padding, left: 0, bottom: 2*padding, right: 0)
        }
        
        collectionView.register(MainScreenGroupCell.self, forCellWithReuseIdentifier: MainScreenGroupCell.reuseIdentifier)
        collectionView.register(HeaderCollectionViewCellMainScreen.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionViewCellMainScreen.reuseIdentifier)
    }
    
    private func settingAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func showError(description: String) {
        settingAlert(title: "Error", message: description)
    }
    
    
    
    //MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainScreenGroupCell.reuseIdentifier, for: indexPath) as? MainScreenGroupCell,
            let viewModel = self.viewModel.cellViewModel(forIndexPath: indexPath) else {
            objectDescription(self, function: #function)
            return UICollectionViewCell()
        }
        cell.viewModel = viewModel
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionViewCellMainScreen.reuseIdentifier, for: indexPath) as? HeaderCollectionViewCellMainScreen else {
            objectDescription(self, function: #function)
            return UICollectionReusableView()
        }
        animatedView = header
        return header
    }
    
    //MARK: call by number
    @objc private func phoneNumberWasPressed(sender: UIButton) {
        guard
            let phoneNumber = sender.titleLabel?.text,
            let url = URL(string: "tel://\(phoneNumber)"),
            UIApplication.shared.canOpenURL(url)
            else {
            objectDescription(self, function: #function)
            return
        }

        if #available(iOS 10, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    //MARK: UIScrollViewDelegate, processing blur
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let animator = animatedView.animator else {
            objectDescription(self, function: #function)
            return
        }
        
        let contentOffsetY = scrollView.contentOffset.y
        animator.fractionComplete = contentOffsetY > 0 ? 0 : abs(contentOffsetY) / 100
    }
}

extension MainScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = indexPath.row == 2 ? 220 : 210
        if view.traitCollection.horizontalSizeClass == .regular {
            return .init(width: view.frame.width, height: height + 50)
        }
        return .init(width: view.frame.width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if view.traitCollection.horizontalSizeClass == .regular {
            return .init(width: view.frame.width, height: 500)
        }
        return .init(width: view.frame.width, height: 260)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if view.traitCollection.horizontalSizeClass == .regular {
            return 40
        }
        return 20
    }
}

