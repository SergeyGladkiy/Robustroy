//
//  MapperAssignmetnScreenMock.swift
//  TrubaPND77Tests
//
//  Created by Serg on 27.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
@testable import TrubaPND77
class MapperAssignmentScreenMock {
    
}

extension MapperAssignmentScreenMock: MapperProtocolModelAssignmentScreen {
    
    func parse(items: [RepresentativableItem]) -> [ItemAssignmentScreen] {
        let item = EntityMockerAssignmentScreen.generateItemsAssignment()
        return item
    }
    
    func errorCheckingForInternetConnection(_ error: NSURLError) -> Bool {
        return EntityMockerAssignmentScreen.errorIsNotConnectionToNet
    }
    
    
}
