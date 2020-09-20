//
//  EntityMocker.swift
//  TrubaPND77Tests
//
//  Created by Serg on 29.07.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
@testable import TrubaPND77

class EntityMockerMainScreen {
    static func generateStaticInfromation() -> [Int: ItemMainScreen] {
        return [0: ItemMainScreen(group: 0, groupName: "Каталог труб ПНД", description: "Весь ассортимент всегда в наличии", attachments: [AttachmentItemMainScreen(imageName: "vodoprovodnaya", attachmentTitle: "Водопроводная", linkHref: "/truba/pnd/vodoprovodnaya/")])]
    }
    
    static func wrongNumberOfItemsInDataBase() -> Int {
        return 4
    }
    
    static func generateItems() -> [Int: ItemMainScreen] {
        return [1: ItemMainScreen(group: 1,
                                  groupName: "Производители труб",
                              description: "Вы можете найти трубу по бренду", attachments: [AttachmentItemMainScreen(imageName: "photo", attachmentTitle: "HYDRO")])]
    }
}
