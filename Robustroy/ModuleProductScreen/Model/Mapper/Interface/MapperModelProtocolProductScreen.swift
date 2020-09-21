//
//  MapperModelProtocolProductScreen.swift
//  TrubaPND77
//
//  Created by Serg on 04.09.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

protocol MapperModelProtocolProductScreen {
    func parse(item: ItemInformation) -> ItemProductScreen?
    func errorCheckingForInternetConnection(_ error: NSURLError) -> Bool
}
