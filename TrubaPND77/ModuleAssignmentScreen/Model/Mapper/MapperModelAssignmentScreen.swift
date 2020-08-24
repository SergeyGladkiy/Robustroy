//
//  MapperModelAssignmentScreen.swift
//  TrubaPND77
//
//  Created by Serg on 22.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

class MapperModelAssignmentScreen {
    
}

extension MapperModelAssignmentScreen: MapperProtocolModelAssignmentScreen {
    func parse(items: [RepresentativableItem]) -> [ItemAssignmentScreen] {
        return items.map { ItemAssignmentScreen(title: $0.name, price: $0.price, urlImage: $0.urlImage, link: $0.linkToDescription)
        }
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
