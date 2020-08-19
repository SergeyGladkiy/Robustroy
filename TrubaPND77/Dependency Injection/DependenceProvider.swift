//
//  DependenceProvider.swift
//  TrubaPND77
//
//  Created by Serg on 18.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import Swinject

class DependenceProvider {
    private static let assembler = Assembler([AppCoordinatorAssambly(), MainScreenAssembly()])
    
    static func resolve<T>() -> T? {
        return DependenceProvider.assembler.resolver.resolve(T.self)
    }
}
