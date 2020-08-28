//
//  ItemAssignmentScreen.swift
//  TrubaPND77
//
//  Created by Serg on 22.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

struct ItemAssignmentScreen {
    let title: String
    let price: String
    let urlImage: String
    let link: String
}

extension ItemAssignmentScreen: Equatable {
    static func == (lhs: ItemAssignmentScreen, rhs: ItemAssignmentScreen) -> Bool {
        if
            lhs.title == rhs.title,
            lhs.price == rhs.price,
            lhs.urlImage == rhs.urlImage,
            lhs.link == rhs.link {
            return true
        }
        return false
    }
}
