//
//  MainScreenCoordinator.swift
//  TrubaPND77
//
//  Created by Serg on 18.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit

class MainScreenCoodinator {
    
}

extension MainScreenCoodinator: BasicRoutingCoordinatorProtocol {
    func start() -> UIViewController? {
        guard let controller: MainScreenViewController = DependenceProvider.resolve() else {
            objectDescription(self, function: #function)
            return nil
        }
        return controller
    }
    
}

extension MainScreenCoodinator: MainScreenCoordinatorProtocol {
    
}
