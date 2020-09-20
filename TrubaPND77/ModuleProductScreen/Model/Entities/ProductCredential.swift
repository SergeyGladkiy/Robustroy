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
    
}

extension ProductCredential {
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

extension ProductCredential: Equatable {
    static func == (lhs: ProductCredential, rhs: ProductCredential) -> Bool {
        if
            lhs.price == rhs.price,
            lhs.urlImage == rhs.urlImage {
            return true
        }
        return false
    }
}
