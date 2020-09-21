//
//  AttachmentItemCatalogScreen.swift
//  TrubaPND77
//
//  Created by Serg on 10.09.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

struct AttachmentItemCatalogScreen: Decodable {
    let attachmentTitle: String
    let linkHref: String
}

extension AttachmentItemCatalogScreen: Equatable {
    static func == (lhs: AttachmentItemCatalogScreen, rhs: AttachmentItemCatalogScreen) -> Bool {
        if lhs.attachmentTitle == rhs.attachmentTitle,
            lhs.linkHref == rhs.linkHref {
            return true
        }
        return false
    }
}
