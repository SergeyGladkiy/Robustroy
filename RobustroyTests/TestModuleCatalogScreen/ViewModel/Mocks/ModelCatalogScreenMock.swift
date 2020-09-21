//
//  ModelCatalogScreenMock.swift
//  TrubaPND77Tests
//
//  Created by Serg on 18.09.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
@testable import Robustroy

class ModelCatalogScreenMock {
    var errorOccured = Observable<CustomError>(observable: .initial)
    var staticInfoCatalog = Observable<[Int : ItemCatalogScreen]>(observable: [:])
}

extension ModelCatalogScreenMock: ModelCatalogScreenProtocol {
    func processingStaticData() {
        staticInfoCatalog.observable = EntityMockerCatalogScreen.generateItems()
    }
}
