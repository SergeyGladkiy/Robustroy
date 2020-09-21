//
//  MenuView.swift
//  TrubaPND77
//
//  Created by Serg on 10.09.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit

protocol MenuViewProtocol: class {
    var delegate: (Int)->() { get set }
    var movabelViewConstrait: NSLayoutConstraint { get }
    func moveTo(item: Int)
    var infoBar: [String] { get set }
}

class MenuView: UIView {
    
    private weak var collectionView: UICollectionView!
    private weak var leadingHorizontalView: NSLayoutConstraint!
    
    private var actionForDelegate: ((Int)->())!
    
    private var dataSource = [String]() {
        didSet {
            settingHorizontalBarView()
            collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        settingLayoutCollectionView()
        settingShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func settingLayoutCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.dataSource = self
        collection.delegate = self
        self.collectionView = collection
        
        if #available(iOS 13.0, *) {
            collectionView.backgroundColor = .systemBackground

        } else {
            collectionView.backgroundColor = .white
        }
        
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.fillSuperview()
        
        collectionView.register(MenuViewCell.self, forCellWithReuseIdentifier: MenuViewCell.reuseIdentifier)
    }
    
    private func settingHorizontalBarView() {
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = .blue
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalBarView)
        
        let horizontalAnchor = horizontalBarView.leadingAnchor.constraint(equalTo: leadingAnchor)
        self.leadingHorizontalView = horizontalAnchor
        
        var height: CGFloat = 3
        if traitCollection.horizontalSizeClass == .regular {
            height = 6
        }
        
        NSLayoutConstraint.activate([
            horizontalAnchor,
            horizontalBarView.bottomAnchor.constraint(equalTo: bottomAnchor),
            horizontalBarView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1 / CGFloat(dataSource.count)),
            horizontalBarView.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    private func settingShadow() {
        layer.shadowOffset = CGSize(width: 0, height: 6)
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 7
    }
}

extension MenuView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuViewCell.reuseIdentifier, for: indexPath) as? MenuViewCell else {
            objectDescription(self, function: #function)
            return UICollectionViewCell()
        }
        cell.viewModel = dataSource[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        actionForDelegate(indexPath.item)
    }
    
}

extension MenuView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let countItems = dataSource.count
        return CGSize(width: frame.width / CGFloat(countItems), height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension MenuView: MenuViewProtocol {
    var infoBar: [String] {
        get {
            return dataSource
        }
        set {
            dataSource = newValue
        }
    }
    
    var delegate: (Int) -> () {
        get {
            return actionForDelegate
        }
        set {
            actionForDelegate = newValue
        }
    }
    
    var movabelViewConstrait: NSLayoutConstraint {
        get {
            return leadingHorizontalView
        }
    }
    
    func moveTo(item: Int) {
        let indexPath = IndexPath(item: item, section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
}
