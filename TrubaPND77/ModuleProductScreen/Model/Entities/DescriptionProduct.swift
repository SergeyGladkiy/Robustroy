//
//  DescriptionProduct.swift
//  TrubaPND77
//
//  Created by Serg on 04.09.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

struct DescriptionProduct {
    let characteristics: Charateristics
    let aboutProduct: About
}

struct Charateristics {
    let info: [String: String]
}

extension Charateristics: CellViewModelProductScreen {
    var reuseIdentifier: String {
        return CharacteristicsProductCell.reuseIdentifier
    }
}

struct About {
    let paragraphs: [String]
    let lists: [String]
}

extension About: CellViewModelProductScreen {
    var reuseIdentifier: String {
        return AboutProductCell.reuseIdentifier
    }
}
