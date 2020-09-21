//
//  NetworkingMock.swift
//  TrubaPND77Tests
//
//  Created by Serg on 27.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
@testable import Robustroy

class NetworkAssignmentScreenMock {
    
}

extension NetworkAssignmentScreenMock: NetworkProtocolAssignmentModule {
    func fetchRepresentItems(completion: @escaping RepresentItemsCompletion) {
        if EntityMockerAssignmentScreen.isFailureComplition {
            if EntityMockerAssignmentScreen.errorIsNotConnectionToNet {
                completion(.failure(.notConnectedToInternet))
            } else {
                completion(.failure(.unknown))
            }
        } else {
            let items = EntityMockerAssignmentScreen.generateRepresentItems()
            completion(.success(items))
        }
    }
}
