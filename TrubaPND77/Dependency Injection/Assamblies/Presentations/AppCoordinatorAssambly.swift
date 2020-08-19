//
//  AppCoordinator.swift
//  TrubaPND77
//
//  Created by Serg on 18.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import Swinject

class AppCoordinatorAssambly: Assembly {
    func assemble(container: Container) {
        container.register(ApplicationCoordinatorProtocol.self) { _ in
            ApplicationCoordinator()
        }.inObjectScope(.container)
    }
}
