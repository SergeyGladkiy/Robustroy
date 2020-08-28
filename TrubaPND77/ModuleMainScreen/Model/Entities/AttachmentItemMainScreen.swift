//
//  AttachmentItemMainScreen.swift
//  TrubaPND77
//
//  Created by Serg on 30.07.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

struct AttachmentItemMainScreen: Decodable {
    let imageName: String
    let attachmentTitle: String
    var linkHref: String?
    var attechmentDescription: String?
}

extension AttachmentItemMainScreen: Equatable {
    static func == (lhs: AttachmentItemMainScreen, rhs: AttachmentItemMainScreen) -> Bool {
        if lhs.imageName == rhs.imageName,
            lhs.attachmentTitle == rhs.attachmentTitle,
            lhs.attechmentDescription == rhs.attechmentDescription,
            lhs.linkHref == rhs.linkHref {
            return true
        }
        return false
    }
}
