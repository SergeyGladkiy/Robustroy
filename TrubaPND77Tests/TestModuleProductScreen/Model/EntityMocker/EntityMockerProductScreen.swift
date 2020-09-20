//
//  EntityMockerProductScreen.swift
//  TrubaPND77Tests
//
//  Created by Serg on 18.09.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
@testable import TrubaPND77

class EntityMockerProductScreen {
    static var isFailureComplition = false
    static var errorIsNotConnectionToNet = false
    static let notConnectedToInternet = "Нет соединения с интернетом"
    static let correctIndex = 0
    
    static func generateItemInformation() -> ItemInformation {
        return ItemInformation(characteristiks: ["characterKey": "characterValue"], infoAboutItem: InfoAboutItem(paragraphs: ["infoParagraph"], lists: ["infoList"]))
    }
    
    static func generateItemProduct() -> ItemProductScreen {
        return ItemProductScreen(descriptionProduct: [
            0: ProductCredential(price: "productPrice", urlImage: "productUrlImage"),
            1: Characteristics(info: ["characterKey": "characterValue"]),
            2: About(paragraphs: ["infoParagraph"], lists: ["infoList"])
        ])
    }
}
