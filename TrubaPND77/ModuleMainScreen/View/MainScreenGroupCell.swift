//
//  MainScreenGroupCell.swift
//  TrubaPND77
//
//  Created by Serg on 05.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit

class MainScreenGroupCell: UICollectionViewCell {
    
    private weak var titleLabel: UILabel!
    private weak var descriptionLabel: UILabel!
    private weak var horizontalCollectionView: UICollectionView!
    
    private var attachments = [AttachmentItemMainScreen]()
    private let padding: CGFloat = 16
    
    weak var viewModel: CellViewModelMainScreen! {
        didSet {
            titleLabel.text = viewModel.titleGroup
            descriptionLabel.text = viewModel.descriptionGroup
            attachments = viewModel.attachmentsGroup
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        settingLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func settingLayout() {
        let label = UILabel()
        label.text = "App Section"
        label.font = .boldSystemFont(ofSize: 27)
        label.numberOfLines = 0
        self.titleLabel = label
        addSubview(titleLabel)
        titleLabel.backgroundColor = .blue
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: padding, bottom: 0, right: padding))
        
        let description = UILabel()
        description.text = "Description"
        description.font = .systemFont(ofSize: 18)
        description.numberOfLines = 0
        self.descriptionLabel = description
        addSubview(descriptionLabel)
        descriptionLabel.backgroundColor = .green
        descriptionLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: padding, bottom: 0, right: padding))
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.horizontalCollectionView = collectionView
        
        //MARK: setting for lyaout of horizontal collection view
        horizontalCollectionView.backgroundColor = .red
        horizontalCollectionView.dataSource = self
        horizontalCollectionView.delegate = self
        horizontalCollectionView.register(MainScreenHorizontalCollectionViewCell.self, forCellWithReuseIdentifier: MainScreenHorizontalCollectionViewCell.reuseIdentifier)
        addSubview(horizontalCollectionView)
        horizontalCollectionView.anchor(top: descriptionLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
}

extension MainScreenGroupCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return attachments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainScreenHorizontalCollectionViewCell.reuseIdentifier, for: indexPath) as? MainScreenHorizontalCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = .lightGray
        cell.viewModel = attachments[indexPath.row]
        return cell
    }
}

extension MainScreenGroupCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: padding/2, left: padding, bottom: 0, right: padding)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = self.frame.width - 3*padding
        let height = self.frame.height - titleLabel.frame.height - descriptionLabel.frame.height - padding/2
        
        if titleLabel.text == "Каталог продукции" {
            width = (width + padding - 10) / 2
        }
        
        if traitCollection.horizontalSizeClass == .regular {
            return .init(width: width/2 - padding, height: height)
        }
        return .init(width: width, height: height)
    }
}
