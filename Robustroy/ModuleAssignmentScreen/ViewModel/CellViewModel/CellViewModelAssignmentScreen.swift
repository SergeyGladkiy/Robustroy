//
//  CellViewModelAssignmentScree.swift
//  TrubaPND77
//
//  Created by Serg on 24.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

class CellViewModelAssignmentScreen {
    let nameProduct: String
    let priceProduct: String
    let imageUrl: String
    
    init(model: ItemAssignmentScreen) {
        self.nameProduct = model.name
        self.priceProduct = model.price
        self.imageUrl = model.urlImage
    }
}

