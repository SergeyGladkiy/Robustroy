//
//  TypeItemGroup.swift
//  TrubaPND77
//
//  Created by Serg on 10.09.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

struct TypeItemGroup: Decodable {
    let indexType: Int
    let titleType: String
    let attachments: [AttachmentItemCatalogScreen]
}

extension TypeItemGroup: Equatable {
    static func == (lhs: TypeItemGroup, rhs: TypeItemGroup) -> Bool {
        if lhs.indexType == rhs.indexType,
            lhs.titleType == rhs.titleType,
            lhs.attachments == rhs.attachments {
            return true
        }
        return false
    }
}

