//
//  EntityMockerAssignmetnScreen.swift
//  TrubaPND77Tests
//
//  Created by Serg on 27.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
@testable import Robustroy

class EntityMockerAssignmentScreen {
    static var isFailureComplition = false
    static var errorIsNotConnectionToNet = false
    static let notConnectedToInternet = "Нет соединения с интернетом"
    static let correctIndex = 0
    
    static func generateRepresentItems() -> [RepresentativableItem] {
        return [RepresentativableItem(name: "ProductName", title: "ProductTitle", price: "ProductPrice", urlImage: "ProductImageUrl", linkToDescription: "ProductLinkToDescription")]
    }
    
    static func generateItemsAssignment() -> [ItemAssignmentScreen] {
        return [ItemAssignmentScreen(name: "ProductName", title: "ProductName", price: "ProductPrice", urlImage: "ProductImageUrl", link: "ProductLinkToDescription")]
    }
}
