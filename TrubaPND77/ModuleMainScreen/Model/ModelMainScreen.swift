//
//  ModelMainScreen.swift
//  TrubaPND77
//
//  Created by Serg on 29.07.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

class ModelMainScreen {
    var errorOccure: Observable<String> = Observable(observable: "")
    private var dictionaryItems = [Int: ItemMainScreen]()
    
    private func installingStaticInformation() {
        guard let path = Bundle.main.path(forResource: "DataMainScreen", ofType: "plist") else {
            errorOccure.observable = "Неверный путь к файлу"
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: [])
            let decoder = PropertyListDecoder()
            let info = try decoder.decode([ItemMainScreen].self, from: data)
            _ = (0..<info.count).map { dictionaryItems[$0] = info[$0] }
        } catch {
            errorOccure.observable = "Неверно декодированный элемент"
        }
    }
    
    init() {
        installingStaticInformation()
    }
}

extension ModelMainScreen: ModelMainScreenProtocol {
    func numberOfItems() -> Int {
        return dictionaryItems.count
    }
    

    func dataOfItem(number: Int) -> ItemMainScreen? {
        guard let info = dictionaryItems[number] else {
            errorOccure.observable = "нет информации"
            return nil
        }

        return info
    }
}
