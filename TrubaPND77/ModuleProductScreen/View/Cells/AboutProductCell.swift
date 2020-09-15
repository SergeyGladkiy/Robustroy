//
//  AboutProductCell.swift
//  TrubaPND77
//
//  Created by Serg on 05.09.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import UIKit

class AboutProductCell: UITableViewCell {

    @IBOutlet weak var stackView: UIStackView!
    var firstProcessing = false
    
    var viewModel: CellViewModelProductScreen? {
        didSet {
            guard let data = viewModel as? About else {
                objectDescription(self, function: #function)
                return
            }
            if firstProcessing == true { return }
            processing(info: data)
        }
    }
    
    private func processing(info aboutProduct: About) {
        if aboutProduct.paragraphs.isEmpty && aboutProduct.lists.isEmpty {
            let label = UILabel()
            label.font = .systemFont(ofSize: 19)
            label.text = "Нет информации"
            stackView.addArrangedSubview(label)
        } else {
            _ = aboutProduct.lists.map {
                let label = UILabel()
                label.font = .systemFont(ofSize: 19)
                label.numberOfLines = 0
                label.text = "• \($0)"
                stackView.addArrangedSubview(label)
            }
            _ = aboutProduct.paragraphs.enumerated().map {
                let label = UILabel()
                label.numberOfLines = 0
                label.font = .systemFont(ofSize: 19)
                label.text = "\($0.element)"
                if $0.offset == 0 {
                    stackView.insertArrangedSubview(label, at: 0)
                } else {
                    stackView.addArrangedSubview(label)
                }
            }
        }
        firstProcessing = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func updateConstraints() {
        super.updateConstraints()
        if traitCollection.horizontalSizeClass == .regular {
            _ = stackView.subviews.map {
                guard let label = $0 as? UILabel else {
                    objectDescription(self, function: #function)
                    return
                }
                label.font = .systemFont(ofSize: 23)
            }
        }
    }
    
}

extension AboutProductCell: ProductScreenCellProtocol {
    
}

