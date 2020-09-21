//
//  ModelMainScreen.swift
//  TrubaPND77
//
//  Created by Serg on 29.07.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

class ModelMainScreen {
    var staticInfо = Observable<[Int: ItemMainScreen]>(observable: [:])
    var errorOccured = Observable<CustomError>(observable: .initial)
}

extension ModelMainScreen: ModelMainScreenProtocol {
    
    func processingStaticInformation() {
        guard let path = Bundle.main.path(forResource: "DataMainScreen", ofType: "plist") else {
            objectDescription(self, function: #function)
            errorOccured.observable = .wrongFilePath
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: [])
            let decoder = PropertyListDecoder()
            let info = try decoder.decode([ItemMainScreen].self, from: data)
            var dict = [Int: ItemMainScreen]()
            _ = (0..<info.count).map { dict[$0] = info[$0] }
            staticInfо.observable = dict
        } catch {
            objectDescription(self, function: #function)
            errorOccured.observable = .decodingError
        }
    }
}
