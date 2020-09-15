//
//  MenuViewCell.swift
//  TrubaPND77
//
//  Created by Serg on 10.09.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit

class MenuViewCell: UICollectionViewCell {
    private weak var titleLabel: UILabel!
    
    var viewModel: String? {
        didSet {
            titleLabel.text = viewModel
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        settingLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if traitCollection.horizontalSizeClass == .regular {
            titleLabel.font = .systemFont(ofSize: 23)
        }
        super.updateConstraints()
    }
    
    private func settingLayout() {
        if #available(iOS 13.0, *) {
            backgroundColor = .systemBackground
        } else {
            backgroundColor = .white
        }
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        self.titleLabel = label
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        addSubview(stackView)
        stackView.fillSuperview()
    }
}
