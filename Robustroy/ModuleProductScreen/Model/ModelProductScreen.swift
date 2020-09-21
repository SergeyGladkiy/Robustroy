//
//  ModelProductScreen.swift
//  TrubaPND77
//
//  Created by Serg on 31.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

class ModelProductScreen {
    private let networking: NetworkProtocolProductModule
    private let mapper: MapperModelProtocolProductScreen
    
    var dataSource = Observable<ItemProductScreen?>(observable: nil)
    var errorOccured = Observable<CustomError>(observable: .initial)
    
    init(networking: NetworkProtocolProductModule, mapper: MapperModelProtocolProductScreen) {
        self.networking = networking
        self.mapper = mapper
    }
}

extension ModelProductScreen: ModelProductScreenProtocol {
    
    func fetchingInformation() {
        networking.fetchItemInformation { [weak self] response in
            guard let self = self else {
                print("ModelAssignmentScreen is deinitialized")
                return
            }
            
            switch response {
            case .success(let data):
                let info = self.mapper.parse(item: data)
                self.dataSource.observable = info
            case .failure(let error):
                let resultCheck = self.mapper.errorCheckingForInternetConnection(error)
                self.errorOccured.observable = resultCheck ? .notConnectedToInternet : .unknown
            }
        }
    }
}
