//
//  ModelAssignmentScreenProtocol.swift
//  TrubaPND77
//
//  Created by Serg on 19.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

protocol ModelAssignmentScreenProtocol {
    var dataSource: Observable<[ItemAssignmentScreen]> { get }
    var errorOccured: Observable<CustomError> { get }
    func fetchingInformation()
}
