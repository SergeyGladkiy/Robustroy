//
//  ProductScreenAssembly.swift
//  TrubaPND77
//
//  Created by Serg on 31.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import Swinject

class ProductScreenAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ProductScreenViewController.self) { (r, arg: String?) in
            let viewModel = r.resolve(ViewModelProductScreenProtocol.self)!
            let router = r.resolve(ProductScreenRouterInput.self, name: arg)!
            return ProductScreenViewController(viewModel: viewModel, router: router)
        }
        
        container.register(ViewModelProductScreenProtocol.self) { r in
            let model = r.resolve(ModelProductScreenProtocol.self)!
            return ViewModelProductScreen(model: model, state: .init(observable: .initial))
        }
        
        container.register(ModelProductScreenProtocol.self) { r in
            let networking = r.resolve(NetworkProtocolProductModule.self)!
            let mapper = r.resolve(MapperModelProtocolProductScreen.self)!
            return ModelProductScreen(networking: networking, mapper: mapper)
        }
        
        container.register(MapperModelProtocolProductScreen.self) { _ in
            MapperModelProductScreen()
        }
    }
}
