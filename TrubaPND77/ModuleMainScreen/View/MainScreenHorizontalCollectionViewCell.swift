//
//  MainScreenHorizontalCollectionViewCell.swift
//  TrubaPND77
//
//  Created by Serg on 11.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit

class MainScreenHorizontalCollectionViewCell: UICollectionViewCell {
    
    private weak var imageViewCategory: UIImageView!
    private weak var titleCategory: UILabel!
    private weak var descriptionCategory: UILabel!
    private var padding: CGFloat = 10
    
    var viewModel: AttachmentItemMainScreen! {
        didSet {
            imageViewCategory.image = UIImage(named: viewModel.imageName)
            titleCategory.text = viewModel.attachmentTitle
            guard let descriptionText = viewModel.attechmentDescription else {
                descriptionCategory.isHidden = true
                return }
            descriptionCategory.text = descriptionText
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutCell() {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "truba")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        self.imageViewCategory = imageView
        imageViewCategory.backgroundColor = .white
        imageViewCategory.heightAnchor.constraint(equalToConstant: self.frame.height/2).isActive = true

        let label = UILabel()
        label.text = "Category"
        label.font = .boldSystemFont(ofSize: 27)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        self.titleCategory = label
        titleCategory.backgroundColor = .blue
        
        let description = UILabel()
        description.text = "Description"
        description.font = .systemFont(ofSize: 18)
        description.adjustsFontSizeToFitWidth = true
        description.numberOfLines = 0
        description.textAlignment = .center
        self.descriptionCategory = description
        descriptionCategory.backgroundColor = .green
        
        let stackView = UIStackView(arrangedSubviews: [
            imageViewCategory, titleCategory, descriptionCategory
        ])
        
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fillProportionally
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        //stackView.isLayoutMarginsRelativeArrangement = true
        //stackView.layoutMargins = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
    }
}
