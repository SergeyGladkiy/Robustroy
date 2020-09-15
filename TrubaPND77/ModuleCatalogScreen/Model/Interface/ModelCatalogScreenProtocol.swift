//
//  ModelCatalogScreenProtocol.swift
//  TrubaPND77
//
//  Created by Serg on 10.09.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

protocol ModelCatalogScreenProtocol {
    var staticInfoCatalog: Observable<[Int: ItemCatalogScreen]> { get }
    var errorOccured: Observable<CustomError> { get }
    func processingStaticData()
}
