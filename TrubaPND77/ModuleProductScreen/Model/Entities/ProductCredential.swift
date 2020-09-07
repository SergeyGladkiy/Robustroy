//
//  ProductCredential.swift
//  TrubaPND77
//
//  Created by Serg on 04.09.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

struct ProductCredential {
    let price: String
    let urlImage: String
    
    init(from item: ItemCredential) {
        self.price = item.priceItem
        self.urlImage = item.urlItemImage
    }
}

extension ProductCredential: CellViewModelProductScreen {
    var reuseIdentifier: String {
        CredentialProductCell.reuseIdentifier
    }
}
