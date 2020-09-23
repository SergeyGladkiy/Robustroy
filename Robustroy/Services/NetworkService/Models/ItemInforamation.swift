//
//  ItemInforamation.swift
//  TrubaPND77
//
//  Created by Serg on 04.09.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

struct ItemInformation {
    let characteristiks: [String: String]
    let infoAboutItem: InfoAboutItem
}

struct InfoAboutItem {
    let paragraphs: [String]
    let lists: [String]
}

