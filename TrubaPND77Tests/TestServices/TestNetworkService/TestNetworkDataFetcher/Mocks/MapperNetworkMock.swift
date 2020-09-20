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
    func parseHtmlForItemInformation(_ data: Data, completion: (Result<ItemInformation, NSURLError>) -> Void) {
        if EntityMockerNetworkService.isMapperParseHtmlCompletionWithItems {
            let items = EntityMockerNetworkService.generateItemInformation()
            completion(.success(items))
        } else {
            let error = EntityMockerNetworkService.nsUrlErrorParseHtml
            completion(.failure(error))
        }
    }
    
    func parsingError(error: NSError) -> NSURLError {
        return .unknown
    }
    
    func parseHtmlForRepresentItems(_ data: Data, completion: (Result<[RepresentativableItem], NSURLError>) -> Void) {
        if EntityMockerNetworkService.isMapperParseHtmlCompletionWithItems {
            let items = EntityMockerNetworkService.generateRepresentItems()
            completion(.success(items))
        } else {
            let error = EntityMockerNetworkService.nsUrlErrorParseHtml
            completion(.failure(error))
        }
    }
    
    
}
