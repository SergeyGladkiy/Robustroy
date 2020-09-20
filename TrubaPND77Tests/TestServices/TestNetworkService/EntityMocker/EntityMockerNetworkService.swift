//
//  EntityMockerNetworkService.swift
//  TrubaPND77Tests
//
//  Created by Serg on 28.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
@testable import TrubaPND77

class EntityMockerNetworkService {
    static var isNetworkingRequestCompletionWithData = false
    static var isMapperParseHtmlCompletionWithItems = false
    static let someError: Error = SomeError()
    static let nsUrlErrorParseHtml = NSURLError.parseHtml
    
    static func generateRepresentItems() -> [RepresentativableItem] {
        return [RepresentativableItem(name: "ProductName", title: "ProductTitle", price: "ProductPrice", urlImage: "ProductImageUrl", linkToDescription: "ProductLinkToDescription")]
    }
    
    static func generateItemInformation() -> ItemInformation {
        return ItemInformation(characteristiks: ["characterKey": "characterValue"], infoAboutItem: InfoAboutItem(paragraphs: ["infoParagraph"], lists: ["infoList"]))
    }
}


struct SomeError {
    
}

extension SomeError: Error {
    var localizedDescription: String {
        return String(describing: self)
    }
}
