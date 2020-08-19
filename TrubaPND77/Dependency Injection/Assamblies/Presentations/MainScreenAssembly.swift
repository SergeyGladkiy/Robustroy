//
//  MainScreenAssembly.swift
//  TrubaPND77
//
//  Created by Serg on 18.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import Swinject

class MainScreenAssembly: Assembly {
    func assemble(container: Container) {
        container.register(MainScreenViewController.self) { (resolver) in
            let viewModel = resolver.resolve(ViewModelMainScreenProtocol.self)!
            let router = resolver.resolve(MainScreenCoordinatorProtocol.self)!
            let layout = StretchyHeaderLayout()
            return MainScreenViewController(viewModel: viewModel, router: router, layout: layout)
        }
        
        container.register(ViewModelMainScreenProtocol.self) { (resolver) in
            let model = resolver.resolve(ModelMainScreenProtocol.self)!
            return ViewModelMainScreen(state: .init(observable: .initial), model: model)
        }
        
        container.register(ModelMainScreenProtocol.self) { _ in
            ModelMainScreen()
        }
        
        container.register(MainScreenCoordinatorProtocol.self) { _ in
            MainScreenCoodinator()
        }
        .implements(BasicRoutingCoordinatorProtocol.self)
        .inObjectScope(.container)
    }
}
