//
//  ModelMainScreenMock.swift
//  TrubaPND77Tests
//
//  Created by Serg on 29.07.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
@testable import Robustroy

class ModelMainScreenMock {
    var errorOccured = Observable<CustomError>(observable: .initial)
    var staticInfо = Observable<[Int : ItemMainScreen]>(observable: [:])
}

extension ModelMainScreenMock: ModelMainScreenProtocol {
    func processingStaticInformation() {
        staticInfо.observable = EntityMockerMainScreen.generateItems()
    }
    
}
