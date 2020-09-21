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
    private weak var imageView: UIImageView!
    
    var viewModel: String? {
        didSet {
            imageView.image = UIImage(named: viewModel!)
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
        if #available(iOS 13.0, *) {
            backgroundColor = .systemBackground
        } else {
            backgroundColor = .white
        }
        
        let viewImage = UIImageView()
        viewImage.contentMode = .scaleAspectFit
        self.imageView = viewImage

        let stackView = UIStackView(arrangedSubviews: [imageView])
        stackView.axis = .vertical
        stackView.alignment = .center
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 4, left: 0, bottom: 10, right: 0))
    }
}
