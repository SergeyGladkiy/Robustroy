//
//  AssignmentScreenCollectionViewCell.swift
//  TrubaPND77
//
//  Created by Serg on 21.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class AssignmentScreenCollectionViewCell: UICollectionViewCell {
    
    private weak var imageView: UIImageView!
    private weak var titleLabel: UILabel!
    private weak var priceLabel: UILabel!
    
    //??????!!!!!!
    private var link = ""
    
    private let padding: CGFloat = 10
    
    weak var viewModel: CellViewModelAssignmentScree! {
        didSet {
            let url = URL(string: API.scheme + API.host + viewModel.imageUrl)
            self.imageView.kf.setImage(with: url)
            self.titleLabel.text = viewModel.titleProduct
            self.priceLabel.text = viewModel.priceProduct
            self.link = viewModel.linkToDescriptionProduct
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        settingLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if traitCollection.horizontalSizeClass == .regular {
            titleLabel.font = .systemFont(ofSize: 15)
            priceLabel.font = .systemFont(ofSize: 20)
        }
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        titleLabel.setContentHuggingPriority(.init(rawValue: 251), for: .vertical)
        titleLabel.setContentHuggingPriority(.init(rawValue: 251), for: .horizontal)
        priceLabel.setContentHuggingPriority(.init(rawValue: 250), for: .vertical)
        priceLabel.setContentHuggingPriority(.init(rawValue: 251), for: .horizontal)
        imageView.setContentCompressionResistancePriority(.init(rawValue: 749), for: .vertical)
    }

    private func settingLayout() {
        backgroundColor = .white
        layer.cornerRadius = 8
        clipsToBounds = true
        
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "trubaTechnical")
        image.contentMode = .scaleAspectFit
        self.imageView = image
        addSubview(imageView)
        imageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
        
        let title = UILabel()
        title.text = "Труба 16т (стенка: 2)"
        //title.text = "Труба SDR26 PN 6,3 (DN 90) стенка: 3,5 газ"
        title.font = .systemFont(ofSize: 12)
        title.textColor = .black
        title.numberOfLines = 0
        self.titleLabel = title
        addSubview(titleLabel)
        titleLabel.anchor(top: imageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: padding, bottom: 0, right: padding))

        let price = UILabel()
        price.text = "8.6 руб. м.п."
        //price.text = "27203.75 руб. м.п."
        price.font = .systemFont(ofSize: 16)
        price.textColor = .black
        price.numberOfLines = 0
        self.priceLabel = price
        addSubview(priceLabel)
        priceLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: padding, bottom: padding, right: padding))
    }
}
