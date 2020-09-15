//
//  ModelCatalogScreen.swift
//  TrubaPND77
//
//  Created by Serg on 10.09.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

class ModelCatalogScreen {
    var staticInfoCatalog = Observable<[Int: ItemCatalogScreen]>(observable: [:])
    var errorOccured = Observable<CustomError>(observable: .initial)
}

extension ModelCatalogScreen: ModelCatalogScreenProtocol {
    
    func processingStaticData() {
        guard let path = Bundle.main.path(forResource: "DataCatalogScreen", ofType: "plist") else {
            objectDescription(self, function: #function)
            errorOccured.observable = .wrongFilePath
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: [])
            let decoder = PropertyListDecoder()
            let info = try decoder.decode([ItemCatalogScreen].self, from: data)
            var dict = [Int: ItemCatalogScreen]()
            _ = (0..<info.count).map { dict[$0] = info[$0] }
            staticInfoCatalog.observable = dict
        } catch {
            objectDescription(self, function: #function)
            errorOccured.observable = .decodingError
        }
    }
    
    
}
