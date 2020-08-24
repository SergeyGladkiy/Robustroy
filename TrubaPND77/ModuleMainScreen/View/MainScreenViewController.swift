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
    private let router: MainScreenRouterInput
    
    //MARK: for blur effect
    private weak var animatedView: AnimatedViewMainScreenInterface!
    
    //private var animator: UIViewPropertyAnimator!
    
    private let padding: CGFloat = 16
    
    init(viewModel: ViewModelMainScreenProtocol, router: MainScreenRouterInput, layout: UICollectionViewLayout) {
        self.viewModel = viewModel
        self.router = router
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func settingLayoutCollectionView() {
        if #available(iOS 13.0, *) {
            collectionView.backgroundColor = .systemBackground
        } else {
            collectionView.backgroundColor = .white
        }
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.register(MainScreenGroupCell.self, forCellWithReuseIdentifier: MainScreenGroupCell.reuseIdentifier)
        
        collectionView.register(HeaderCollectionViewCellMainScreen.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionViewCellMainScreen.reuseIdentifier)
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
        UIApplication.shared.open(url)
    }
    
    //MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainScreenGroupCell.reuseIdentifier, for: indexPath) as? MainScreenGroupCell,
            let cellViewModel = self.viewModel.cellViewModel(forIndexPath: indexPath) else {
            objectDescription(self, function: #function)
            return UICollectionViewCell()
        }
        cell.viewModel = cellViewModel
        
        cell.handlerTapOnCell = { [weak self] link, title in
            guard let self = self else {
                print("MainScreenViewController is deinitialized")
                return
            }
            self.router.transitionToAssignmentScreen(link: link, title: title)
        }
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        let heighTabBar = self.tabBarController?.tabBar.frame.height ?? 49
        let index: CGFloat = heighTabBar == 49 ? 4 : 6

        return .init(top: padding, left: 0, bottom: index*padding, right: 0)
    }
}

