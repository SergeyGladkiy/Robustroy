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
    
    private let padding: CGFloat = 16
    
    private let titleItems = TitlesNavigationItem()
    private var attachments = [AttachmentItemMainScreen]()
    private var indexGroup: Int!
    
    weak var viewModel: CellViewModelMainScreen! {
        didSet {
            indexGroup = viewModel.group
            titleLabel.text = viewModel.titleGroup
            descriptionLabel.text = viewModel.descriptionGroup
            attachments = viewModel.attachmentsGroup
        }
    }
    
    var handlerTapOnCell: ((String, String)->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        settingLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if traitCollection.horizontalSizeClass == .regular {
            titleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
            descriptionLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        }
        super.updateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if traitCollection.horizontalSizeClass == .regular {
            titleLabel.font = .boldSystemFont(ofSize: 35)
            descriptionLabel.font = .systemFont(ofSize: 28)
        }
    }
    
    private func settingLayout() {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "App Section"
        label.font = .boldSystemFont(ofSize: 23)
        self.titleLabel = label
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: padding, bottom: 0, right: padding))
        
        let description = UILabel()
        description.text = "Description"
        description.font = .systemFont(ofSize: 15)
        description.numberOfLines = 0
        self.descriptionLabel = description
        addSubview(descriptionLabel)
        descriptionLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: padding, bottom: 0, right: padding))
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.horizontalCollectionView = collectionView
        
        //MARK: setting for lyaout of horizontal collection view
        if #available(iOS 13.0, *) {
            horizontalCollectionView.backgroundColor = .systemBackground
        } else {
            horizontalCollectionView.backgroundColor = .white
        }
        horizontalCollectionView.showsHorizontalScrollIndicator = false
        horizontalCollectionView.dataSource = self
        horizontalCollectionView.delegate = self
        horizontalCollectionView.register(MainScreenGroupCollectionViewCell.self, forCellWithReuseIdentifier: MainScreenGroupCollectionViewCell.reuseIdentifier)
        addSubview(horizontalCollectionView)
        horizontalCollectionView.anchor(top: descriptionLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
}

extension MainScreenGroupCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return attachments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainScreenGroupCollectionViewCell.reuseIdentifier, for: indexPath) as? MainScreenGroupCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.viewModel = attachments[indexPath.row]
        return cell
    }
}

extension MainScreenGroupCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexGroup != 2 {
            guard let handler = handlerTapOnCell,
                let link = attachments[indexPath.row].linkHref  else {
                objectDescription(self, function: #function)
                return }
            let title = titleItems.data[indexGroup]![indexPath.row]
            handler(link, title)
        }
    }
}

extension MainScreenGroupCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: padding, left: padding, bottom: padding, right: padding)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let inset: CGFloat = 10
        var width = self.frame.width - 2*padding
        let height = self.frame.height - titleLabel.frame.height - descriptionLabel.frame.height - 2*padding
        
        if traitCollection.horizontalSizeClass == .regular {
            width = indexGroup == 0 ? width - padding : width
            return .init(width: (width - 3*inset)/4, height: height)
        }
        return .init(width: (width - padding)/2, height: height)
    }
}
