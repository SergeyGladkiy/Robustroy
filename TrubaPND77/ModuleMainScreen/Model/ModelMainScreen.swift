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
        let numberOfSection = 3
        let info = [
            ItemMainScreen(sectionName: "Каталог труб ПНД по назначению",
                           description: "Весь ассортимент всегда в наличии"),
            ItemMainScreen(sectionName: "Производители труб",
                           description: "Вы можете найти трубу по бренду"),
            ItemMainScreen(sectionName: "Как мы работаем",
                           description: "Один день от заказа до получения товара")
        ]
        
        _ = (0..<numberOfSection).map { dictionaryItems[$0] = info[$0] }
    }
    
    init() {
        installingStaticInformation()
    }
}

extension ModelMainScreen: ModelMainScreenProtocol {
    func numberOfItem() -> Int {
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
