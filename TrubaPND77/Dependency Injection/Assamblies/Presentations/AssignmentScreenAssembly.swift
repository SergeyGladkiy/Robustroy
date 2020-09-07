//
//  AssignmentScreenAssembly.swift
//  TrubaPND77
//
//  Created by Serg on 19.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import Swinject

class AssignmentScreenAssembly: Assembly {
    func assemble(container: Container) {
        container.register(AssignmentScreenViewController.self) { r in
            let viewModel = r.resolve(ViewModelAssignmentScreenProtocol.self)!
            let router = r.resolve(AssignmentScreenRouterInput.self)!
            let layout = UICollectionViewFlowLayout()
            return AssignmentScreenViewController(viewModel: viewModel, router: router, layout: layout)
        }
        
        container.register(ViewModelAssignmentScreenProtocol.self) { r in
            let model = r.resolve(ModelAssignmentScreenProtocol.self)!
            return ViewModelAssignmentScreen(model: model, state: .init(observable: .initial))
        }
        
        container.register(ModelAssignmentScreenProtocol.self) { r in
            let network = r.resolve(NetworkProtocolAssignmentModule.self)!
            let mapper = r.resolve(MapperModelProtocolAssignmentScreen.self)!
            return ModelAssignmentScreen(networking: network, mapper: mapper)
        }
        
        container.register(MapperModelProtocolAssignmentScreen.self) { _ in
            MapperModelAssignmentScreen()
        }
    }
}
