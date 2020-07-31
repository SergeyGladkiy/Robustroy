//
//  ModelMainScreenMock.swift
//  TrubaPND77Tests
//
//  Created by Serg on 29.07.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
@testable import TrubaPlastyk

class ModelMainScreenMock {
    var errorOccure: Observable<String> = Observable<String>(observable: "")
}

extension ModelMainScreenMock: ModelMainScreenProtocol {
    
    func dataOfItem(number: Int) -> ItemMainScreen? {
        return EntityMocker.generateItemMainScreenForFirstSection()
    }
    
    func numberOfItems() -> Int {
        return EntityMocker.generateCorrectQuantitySections()
    }
    
    
}
