//
//  MapperProtocolModelAssignmentScreen.swift
//  TrubaPND77
//
//  Created by Serg on 22.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

protocol MapperModelProtocolAssignmentScreen {
    func parse(items: [RepresentativableItem]) -> [ItemAssignmentScreen]
    func errorCheckingForInternetConnection(_ error: NSURLError) -> Bool
}
