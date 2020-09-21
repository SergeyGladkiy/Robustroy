//
//  ModelAssignmentScreenMock.swift
//  TrubaPND77Tests
//
//  Created by Serg on 27.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
@testable import Robustroy

class ModelAssignmentScreenMock {
    var dataSource = Observable<[ItemAssignmentScreen]>(observable: [])
    var errorOccured = Observable<CustomError>(observable: .initial)
}

extension ModelAssignmentScreenMock: ModelAssignmentScreenProtocol {
    func fetchingInformation() {
        let queue = DispatchQueue(label: "asyncQueue", qos: .utility, attributes: .concurrent)
        
        queue.async { [weak self] in
            guard let self = self else { return }
            
            self.dataSource.observable = EntityMockerAssignmentScreen.generateItemsAssignment()
        }
        
    }
}
