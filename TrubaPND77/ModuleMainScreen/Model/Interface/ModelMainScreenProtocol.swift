//
//  ModelMainScreenProtocol.swift
//  TrubaPND77
//
//  Created by Serg on 29.07.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

protocol ModelMainScreenProtocol {
    var staticInfо: Observable<[Int: ItemMainScreen]> { get }
    var errorOccure: Observable<CustomError> { get }
    func processingStaticInformation()
}
