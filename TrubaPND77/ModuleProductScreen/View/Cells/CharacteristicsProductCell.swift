//
//  CharacteristicsProductCell.swift
//  TrubaPND77
//
//  Created by Serg on 05.09.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import UIKit

class CharacteristicsProductCell: UITableViewCell {

    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var assignment: UILabel!
    @IBOutlet weak var sdr: UILabel!
    @IBOutlet weak var diameter: UILabel!
    @IBOutlet weak var weight: UILabel!
    
    private let titlesArray = ["Тип:", "Назначение:", "SDR:", "Диаметр:", "Вес брутто (кг/м):"]
    
    var viewModel: CellViewModelProductScreen? {
        didSet {
            guard let data = viewModel as? Charateristics else {
                objectDescription(self, function: #function)
                return
            }
            processing(characters: data.info)
        }
    }
    
    
    private func processing(characters: [String: String]) {
        if characters.isEmpty {
            _ = mainStackView.subviews.map { $0.removeFromSuperview() }
            let label = UILabel()
            let font: UIFont = traitCollection.horizontalSizeClass == .regular ? .systemFont(ofSize: 23) : .systemFont(ofSize: 18)
            label.font = font
            label.text = "Нет информации"
            mainStackView.addArrangedSubview(label)
        } else {
            _ = [type, assignment, sdr, diameter, weight].enumerated().map {
                let titleText = titlesArray[$0.offset]
                guard let value = characters[titleText] else {
                    $0.element?.superview?.removeFromSuperview()
                    return
                }
                $0.element?.text = value
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    override func updateConstraints() {
        super.updateConstraints()
        if traitCollection.horizontalSizeClass == .regular {
            type.font = .systemFont(ofSize: 23)
            assignment.font = .systemFont(ofSize: 23)
            sdr.font = .systemFont(ofSize: 23)
            diameter.font = .systemFont(ofSize: 23)
            weight.font = .systemFont(ofSize: 23)
        }
    }
    
}

extension CharacteristicsProductCell: ProductScreenCellProtocol {
    
}

