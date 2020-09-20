//
//  EntityMockerCatalogScreen.swift
//  TrubaPND77Tests
//
//  Created by Serg on 18.09.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
@testable import TrubaPND77

class EntityMockerCatalogScreen {
    static func generateStaticInfromation() -> [Int: ItemCatalogScreen] {
        return [0: ItemCatalogScreen(groupTitle: "titleFirstGroup", typesGroup: [TypeItemGroup(indexType: 0, titleType: "titleTypeFirstGroup", attachments: [AttachmentItemCatalogScreen(attachmentTitle: "titleAttachFirstGroup", linkHref: "linkHrefFirstGroup")])])]
    }
    
    static func wrongNumberOfItemsInDataBase() -> Int {
        return 4
    }
    
    static func generateItems() -> [Int: ItemCatalogScreen] {
        return [
            0: ItemCatalogScreen(groupTitle: "titleFirstGroup", typesGroup: [TypeItemGroup(indexType: 0, titleType: "titleTypeFirstGroup", attachments: [AttachmentItemCatalogScreen(attachmentTitle: "titleAttachFirstGroup", linkHref: "linkHrefFirstGroup")])]),
            1: ItemCatalogScreen(groupTitle: "titleSecondGroup", typesGroup: [TypeItemGroup(indexType: 1, titleType: "titleTypeSecondGroup", attachments: [AttachmentItemCatalogScreen(attachmentTitle: "titleAttachSecondGroup", linkHref: "linkHrefSecondGroup")])])
        ]
    }
}
