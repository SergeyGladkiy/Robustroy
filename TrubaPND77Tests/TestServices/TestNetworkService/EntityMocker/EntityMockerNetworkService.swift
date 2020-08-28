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
    static var isMapperParseHtmlCompletionWithRepresentItems = false
    static let someError: Error = SomeError()
    static let nsUrlErrorParseHtml = NSURLError.parseHtml
    
    static func generateRepresentItems() -> [RepresentativableItem] {
        return [RepresentativableItem(name: "ProductName", price: "ProductPrice", urlImage: "ProductImageUrl", linkToDescription: "ProductLinkToDescription")]
    }
}


struct SomeError {
    
}

extension SomeError: Error {
    var localizedDescription: String {
        return String(describing: self)
    }
}
