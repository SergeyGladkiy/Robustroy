//
//  NetworkProductScreenMock.swift
//  TrubaPND77Tests
//
//  Created by Serg on 18.09.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
@testable import Robustroy

class NetworkProductScreenMock {
    
}

extension NetworkProductScreenMock: NetworkProtocolProductModule {
    func fetchItemInformation(completion: @escaping ItemInfoCompletion) {
        if EntityMockerProductScreen.isFailureComplition {
            if EntityMockerProductScreen.errorIsNotConnectionToNet {
                completion(.failure(.notConnectedToInternet))
            } else {
                completion(.failure(.unknown))
            }
        } else {
            let items = EntityMockerProductScreen.generateItemInformation()
            completion(.success(items))
        }
    }
}
