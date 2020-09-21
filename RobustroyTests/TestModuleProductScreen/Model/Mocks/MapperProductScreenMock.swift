//
//  MapperProductScreenMock.swift
//  TrubaPND77Tests
//
//  Created by Serg on 18.09.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
@testable import Robustroy
class MapperProductScreenMock {
    
}

extension MapperProductScreenMock: MapperModelProtocolProductScreen {
    func parse(item: ItemInformation) -> ItemProductScreen? {
        return EntityMockerProductScreen.generateItemProduct()
    }
    
    func errorCheckingForInternetConnection(_ error: NSURLError) -> Bool {
        return EntityMockerProductScreen.errorIsNotConnectionToNet
    }
    
    
}
