//
//  CellViewModelMainScreen.swift
//  TrubaPND77
//
//  Created by Serg on 29.07.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

class CellViewModelMainScreen {
    let titleGroup: String
    let descriptionGroup: String
    let attachmentsGroup: [AttachmentItemMainScreen]
    
    init(model: ItemMainScreen) {
        titleGroup = model.sectionName
        descriptionGroup = model.description
        attachmentsGroup = model.attachments
    }
}
