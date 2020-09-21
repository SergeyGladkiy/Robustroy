//
//  CellViewModelMainScreen.swift
//  TrubaPND77
//
//  Created by Serg on 29.07.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

class CellViewModelMainScreen {
    let group: Int
    let titleGroup: String
    let descriptionGroup: String
    let attachmentsGroup: [AttachmentItemMainScreen]
    
    init(model: ItemMainScreen) {
        group = model.group
        titleGroup = model.groupName
        descriptionGroup = model.description
        attachmentsGroup = model.attachments
    }
}
