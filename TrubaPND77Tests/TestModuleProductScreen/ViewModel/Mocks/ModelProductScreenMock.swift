//
//  ModelProductScreenMock.swift
//  TrubaPND77Tests
//
//  Created by Serg on 18.09.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
@testable import TrubaPND77

class ModelProductScreenMock {
    var dataSource = Observable<ItemProductScreen?>(observable: nil)
    var errorOccured = Observable<CustomError>(observable: .initial)
}

extension ModelProductScreenMock: ModelProductScreenProtocol {
    
    func fetchingInformation() {
        let queue = DispatchQueue(label: "asyncQueue", qos: .utility, attributes: .concurrent)
        
        queue.async { [weak self] in
            guard let self = self else { return }
            
            self.dataSource.observable = EntityMockerProductScreen.generateItemProduct()
        }
        
    }
}
