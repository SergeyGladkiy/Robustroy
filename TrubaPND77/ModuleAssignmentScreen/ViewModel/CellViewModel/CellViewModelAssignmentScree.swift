//
//  CellViewModelAssignmentScree.swift
//  TrubaPND77
//
//  Created by Serg on 24.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

class CellViewModelAssignmentScree {
    let titleProduct: String
    let priceProduct: String
    let imageUrl: String
    let linkToDescriptionProduct: String
    
    init(model: ItemAssignmentScreen) {
        self.titleProduct = model.title
        self.priceProduct = model.price
        self.imageUrl = model.urlImage
        self.linkToDescriptionProduct = model.link
    }
}

