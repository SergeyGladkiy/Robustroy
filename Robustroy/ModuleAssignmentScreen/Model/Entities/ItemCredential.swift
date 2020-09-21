//
//  ItemCredential.swift
//  TrubaPND77
//
//  Created by Serg on 04.09.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

struct ItemCredential {
    let link: String
    let titleItem: String
    let priceItem: String
    let urlItemImage: String
    
    init(from item: ItemAssignmentScreen) {
        self.link = item.link
        self.titleItem = item.title
        self.priceItem = item.price
        self.urlItemImage = item.urlImage
    }
}
