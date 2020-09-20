//
//  CatalogScreenViewController.swift
//  TrubaPND77
//
//  Created by Serg on 10.09.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit

class CatalogScreenViewController: UICollectionViewController {
    private let viewModel: ViewModelCatalogScreenProtocol
    private let router: CatalogScreenRouterInput
    private let menuView: MenuViewProtocol
    
    private var topInset: CGFloat = 50
    
    init(viewModel: ViewModelCatalogScreenProtocol, router: CatalogScreenRouterInput, menuView: MenuViewProtocol) {
        self.viewModel = viewModel
        self.router = router
        self.menuView = menuView
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingLayout()
        settingNaviagation()
        setupMenuBarCatalog()
        
        viewModel.state.bind { [weak self] (state) in
            guard let self = self else {
                print("CatalogScreenViewController is deinitialized")
                return
            }

            switch state {
            case .initial:
                return
            case .readyToShowItems:
                self.menuView.infoBar = self.viewModel.getInfoBarMenuView()
                self.collectionView.reloadData()
            case .errorOccured(let unknownError):
                self.showInfoAlert(description: unknownError)
            }
        }
        viewModel.getCatalogInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //MARK: setting navigationBar when the controller appears
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.layoutIfNeeded()
    }
    
    
    
    private func settingLayout() {
        if #available(iOS 13.0, *) {
            collectionView.backgroundColor = .secondarySystemBackground

        } else {
            collectionView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        }
        
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        //MARK: for rid error of inset cell of collection view
        self.edgesForExtendedLayout = [.bottom]
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.contentInset = .init(top: topInset, left: 0, bottom: 0, right: 0)
        collectionView.register(MenuCellCatalogScreen.self, forCellWithReuseIdentifier: MenuCellCatalogScreen.reuseIdentifier)
    }
    
    private func settingNaviagation() {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        let imageForTitle = UIImageView()
        imageForTitle.image = UIImage(named: "miniLogo")
        navigationItem.titleView = imageForTitle
    }
    
    private func setupMenuBarCatalog() {
        guard let menu = menuView as? UIView else {
            objectDescription(self, function: #function)
            return
        }
        
        view.addSubview(menu)
        
        menu.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: view.frame.width, height: topInset))
        
        menuView.delegate = { [weak self] index in
            guard let self = self else {
                print("CatalogScreenViewController is deinitialized")
                return
            }
            self.scrollToMenuIndex(menuIndex: index)
        }
    }
    
    private func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
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
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCellCatalogScreen.reuseIdentifier, for: indexPath) as? MenuCellCatalogScreen,
            let cellViewModel = self.viewModel.cellViewModel(forIndexPath: indexPath) else {
                objectDescription(self, function: #function)
                return UICollectionViewCell()
        }
        cell.viewModel = cellViewModel
        
        cell.handlerTapOnCell = { [weak self] link, title in
            guard let self = self else {
                print("CatalogScreenViewController is deinitialized")
                return
            }
            self.router.transitionToAssignmentScreen(link: link, title: title)
        }
        
        return cell
    }
    
    //MARK: UIScrollViewDelegate
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let count = viewModel.numberOfRows()
        guard count > 0 else { return }
        menuView.movabelViewConstrait.constant = scrollView.contentOffset.x / CGFloat(count)
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.pointee.x / collectionView.frame.width)
        menuView.moveTo(item: index)
    }
}

extension CatalogScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let heightTabBar = tabBarController?.tabBar.frame.height else {
            objectDescription(self, function: #function)
            return .zero
        }
        
        return CGSize(width: collectionView.frame.width , height: collectionView.frame.height - topInset - heightTabBar)
    }
}

