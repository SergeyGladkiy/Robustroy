//
//  ItemProductScreen.swift
//  TrubaPND77
//
//  Created by Serg on 04.09.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

struct ItemProductScreen {
    static var productCredential: ProductCredential?
    let descriptionProduct: [Int: CellViewModelProductScreen]
}

extension ItemProductScreen: Equatable {
    static func == (lhs: ItemProductScreen, rhs: ItemProductScreen) -> Bool {
        guard
            let lhsCredential = lhs.descriptionProduct[0] as? ProductCredential,
            let rhsCredential = rhs.descriptionProduct[0] as? ProductCredential,
            let lhsCharacter = lhs.descriptionProduct[1] as? Characteristics,
            let rhsCharacter = rhs.descriptionProduct[1] as? Characteristics,
            let lhsAbout = lhs.descriptionProduct[2] as? About,
            let rhsAbout = rhs.descriptionProduct[2] as? About else {
            return false
        }

        if
            lhsCredential == rhsCredential,
            lhsCharacter == rhsCharacter,
            lhsAbout == rhsAbout {
            return true
        }
        return false
    }
}

