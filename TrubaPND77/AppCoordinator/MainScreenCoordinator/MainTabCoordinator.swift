//
//  MainScreenCoordinator.swift
//  TrubaPND77
//
//  Created by Serg on 18.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit

class MainTabCoordinator {
    private weak var mainScreenViewController: MainScreenViewController!
    private weak var assignmentScreenViewController: AssignmentScreenViewController!
    private weak var productScreenViewController: ProductScreenViewController!
    private var titleProduct = ""
}

extension MainTabCoordinator: BasicRoutingCoordinatorProtocol {
    func start() -> UIViewController? {
        guard let controller: MainScreenViewController = DependenceProvider.resolve() else {
            objectDescription(self, function: #function)
            return nil
        }
        self.mainScreenViewController = controller
        return self.mainScreenViewController
    }
    
}

extension MainTabCoordinator: MainScreenRouterInput {
    func transitionToAssignmentScreen(link: String, title: String) {
        //MARK: change url path for network request
        API.path = link
        guard
            let assignmentController: AssignmentScreenViewController = DependenceProvider.resolve(),
            let nav = mainScreenViewController.navigationController else {
            //MARK: ??? atempt setting a parameter in func objDesc for optional
            objectDescription(self, function: #function)
            return }
        self.assignmentScreenViewController = assignmentController
        self.assignmentScreenViewController.navigationItem.title = title
        nav.pushViewController(assignmentScreenViewController, animated: true)
    }
}

extension MainTabCoordinator: AssignmentScreenRouterInput {
    func transitionToProductScreen(with info: ItemCredential) {
        API.path = info.link
        guard
            let productController: ProductScreenViewController = DependenceProvider.resolve() else {
                objectDescription(self, function: #function)
                return }
        ItemProductScreen.productCredential = ProductCredential(from: info)
        self.titleProduct = info.titleItem
        productController.navigationItem.title = info.titleItem
        self.productScreenViewController = productController
        assignmentScreenViewController.navigationController?.pushViewController(productController, animated: true)
    }
}

extension MainTabCoordinator: ProductScreenRouterInput {
    func transitionToOrderScreen() {
        let vc = OrderScreenViewController(nibName: "OrderScreenViewController", bundle: Bundle(for: OrderScreenViewController.self))
        vc.productDescription = self.titleProduct
        assignmentScreenViewController.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
}
