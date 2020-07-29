//
//  ModelMainScreenProtocol.swift
//  TrubaPND77
//
//  Created by Serg on 29.07.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

protocol ModelMainScreenProtocol {
    var errorOccure: Observable<String> { get }
    func dataOfItem(number: Int) -> ItemMainScreen?
    func numberOfItem() -> Int
}
