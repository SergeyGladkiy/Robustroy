//
//  ItemMainScreen.swift
//  TrubaPND77
//
//  Created by Serg on 29.07.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

struct ItemMainScreen: Decodable {
    let group: Int
    let groupName: String
    let description: String
    let attachments: [AttachmentItemMainScreen]
}

extension ItemMainScreen: Equatable {
    static func == (lhs: ItemMainScreen, rhs: ItemMainScreen) -> Bool {
        if lhs.group == rhs.group,
            lhs.groupName == rhs.groupName,
            lhs.description == rhs.description,
            lhs.attachments == rhs.attachments {
            return true
        }
        return false
    }
}
