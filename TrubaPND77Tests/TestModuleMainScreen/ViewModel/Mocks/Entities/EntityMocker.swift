//
//  EntityMocker.swift
//  TrubaPND77Tests
//
//  Created by Serg on 29.07.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
@testable import TrubaPND77

class EntityMocker {
    static func generateCorrectQuantitySections() -> Int {
        return 3
    }
    
    static func generateItemMainScreenForFirstSection() -> ItemMainScreen {
        return ItemMainScreen(sectionName: "Производители труб",
                              description: "Вы можете найти трубу по бренду", attachments: [AttachmentItemMainScreen(imageName: "photo", attachmentTitle: "MAGNUM")])
    }
    
    
}
