//
//  MapperModelProductScreen.swift
//  TrubaPND77
//
//  Created by Serg on 04.09.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

class MapperModelProductScreen {
    
}

extension MapperModelProductScreen: MapperModelProtocolProductScreen {
    func parse(item: ItemInformation) -> ItemProductScreen? {
        guard let credentials = ItemProductScreen.productCredential else {
            objectDescription(self, function: #function)
            return nil
        }
        return ItemProductScreen(descriptionProduct: [
            0: credentials,
            1: Charateristics(info: item.characteristiks),
            2: About(paragraphs: item.infoAboutItem.paragraphs, lists: item.infoAboutItem.lists)])
    }
    
    func errorCheckingForInternetConnection(_ error: NSURLError) -> Bool {
        if error == .notConnectedToInternet {
            return true
        }
        //MARK: to understand what the error is
        print(error)
        return false
    }
}
