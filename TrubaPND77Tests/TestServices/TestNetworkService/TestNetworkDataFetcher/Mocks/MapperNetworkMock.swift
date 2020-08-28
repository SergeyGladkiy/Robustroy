//
//  MapperNetworkMock.swift
//  TrubaPND77Tests
//
//  Created by Serg on 28.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
@testable import TrubaPND77

class MapperNetworkMock {
    
}

extension MapperNetworkMock: MapperNetworkProtocol {
    func parsingError(error: NSError) -> NSURLError {
        return .unknown
    }
    
    func parseHtml(_ data: Data, complition: (Result<[RepresentativableItem], NSURLError>) -> Void) {
        if EntityMockerNetworkService.isMapperParseHtmlCompletionWithRepresentItems {
            let items = EntityMockerNetworkService.generateRepresentItems()
            complition(.success(items))
        } else {
            let error = EntityMockerNetworkService.nsUrlErrorParseHtml
            complition(.failure(error))
        }
    }
    
    
}
