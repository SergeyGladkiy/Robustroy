//
//  File.swift
//  TrubaPND77Tests
//
//  Created by Serg on 28.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
@testable import Robustroy

class NetworkingMock {
    
}

extension NetworkingMock: NetworkingProtocol {
    func request(with url: URL, completion: @escaping (Data?, Error?) -> Void) {
        if EntityMockerNetworkService.isNetworkingRequestCompletionWithData {
            let data = "{ some data }".data(using: .utf8)
            completion(data, nil)
        } else {
            let error = EntityMockerNetworkService.someError
            completion(nil, error)
        }
        
    }
}
