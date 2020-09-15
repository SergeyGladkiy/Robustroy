//
//  CatalogScreenAssembly.swift
//  TrubaPND77
//
//  Created by Serg on 10.09.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import Swinject

class CatalogScreenAssembly: Assembly {
    func assemble(container: Container) {
        container.register(CatalogScreenViewController.self) { (resolver) in
            let viewModel = resolver.resolve(ViewModelCatalogScreenProtocol.self)!
            let router = resolver.resolve(CatalogScreenRouterInput.self)!
            let customView = resolver.resolve(MenuViewProtocol.self)!
            return CatalogScreenViewController(viewModel: viewModel, router: router, menuView: customView)
        }
        
        container.register(ViewModelCatalogScreenProtocol.self) { (resolver) in
            let model = resolver.resolve(ModelCatalogScreenProtocol.self)!
            return ViewModelCatalogScreen(state: .init(observable: .initial), model: model)
        }
        
        container.register(ModelCatalogScreenProtocol.self) { _ in
            ModelCatalogScreen()
        }
        
        container.register(MenuViewProtocol.self) { _ in
            MenuView()
        }
        
        //MARK: assign several protocols
        container.register(CatalogScreenRouterInput.self) { _ in
            CatalogTabCoordinator()
        }
        .implements(BasicRoutingCoordinatorProtocol.self)
        .implements(AssignmentScreenRouterInput.self, name: "catalog")
        .implements(ProductScreenRouterInput.self, name: "catalog")
        .inObjectScope(.container)
        
    }
}
