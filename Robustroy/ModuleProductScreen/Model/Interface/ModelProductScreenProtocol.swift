//
//  ModelProductScreenProtocol.swift
//  TrubaPND77
//
//  Created by Serg on 31.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

protocol ModelProductScreenProtocol {
    var dataSource: Observable<ItemProductScreen?> { get }
    var errorOccured: Observable<CustomError> { get }
    func fetchingInformation()
}
