//
//  CredentialProductCell.swift
//  TrubaPND77
//
//  Created by Serg on 05.09.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import UIKit

class CredentialProductCell: UITableViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    
    var viewModel: CellViewModelProductScreen? {
        didSet {
            guard let data = viewModel as? ProductCredential else {
                objectDescription(self, function: #function)
                return
            }
            let url = URL(string: API.scheme + API.host + data.urlImage)
            self.productImage.kf.indicatorType = .activity
            self.productImage.kf.setImage(with: url)
            self.priceLabel.text = data.price + " м.п."
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        buyButton.layer.cornerRadius = 5
        buyButton.layer.masksToBounds = true
        
        let selector = NSSelectorFromString("orderButtonIsPressed")
        buyButton.addTarget(nil, action: selector, for: .touchUpInside)
    }

    override func updateConstraints() {
        if traitCollection.horizontalSizeClass == .regular {
            buyButton.titleLabel?.font = .boldSystemFont(ofSize: 26)
            priceLabel.font = .boldSystemFont(ofSize: 26)
        }
        super.updateConstraints()
    }
    
}

extension CredentialProductCell: ProductScreenCellProtocol {
    
}
