//
//  DescriptionProduct.swift
//  TrubaPND77
//
//  Created by Serg on 04.09.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

struct DescriptionProduct {
    let characteristics: Characteristics
    let aboutProduct: About
}

struct Characteristics {
    let info: [String: String]
}

extension Characteristics: CellViewModelProductScreen {
    var reuseIdentifier: String {
        return CharacteristicsProductCell.reuseIdentifier
    }
}

extension Characteristics: Equatable {
    static func == (lhs: Characteristics, rhs: Characteristics) -> Bool {
        if
            lhs.info == rhs.info {
            return true
        }
        return false
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

extension About: Equatable {
    static func == (lhs: About, rhs: About) -> Bool {
        if
            lhs.paragraphs == rhs.paragraphs,
            lhs.lists == rhs.lists {
            return true
        }
        return false
    }
}
