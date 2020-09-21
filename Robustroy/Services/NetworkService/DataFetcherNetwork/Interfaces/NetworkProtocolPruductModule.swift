//
//  NetworkProtocolProductModul.swift
//  TrubaPND77
//
//  Created by Serg on 31.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

typealias ItemInfoCompletion = (Result<ItemInformation, NSURLError>)-> Void

protocol NetworkProtocolProductModule {
    func fetchItemInformation(completion: @escaping ItemInfoCompletion)
}
