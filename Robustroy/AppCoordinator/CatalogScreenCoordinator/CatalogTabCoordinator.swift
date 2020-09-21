//
//  CatalogTabCoordinator.swift
//  TrubaPND77
//
//  Created by Serg on 10.09.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit

class CatalogTabCoordinator {
    private weak var catalogScreenViewController: CatalogScreenViewController!
    private weak var assignmentScreenViewController: AssignmentScreenViewController!
    private weak var productScreenViewController: ProductScreenViewController!
    private var titleProduct = ""
}

extension CatalogTabCoordinator: BasicRoutingCoordinatorProtocol {
    func start() -> UIViewController? {
        guard let controller: CatalogScreenViewController = DependenceProvider.resolve() else {
            objectDescription(self, function: #function)
            return nil
        }
        self.catalogScreenViewController = controller
        return self.catalogScreenViewController
    }
    
}

extension CatalogTabCoordinator: CatalogScreenRouterInput {
    fileprivate func customizingNavigationBar(_ nav: UINavigationController) {
        let imageForBar = UINavigationBar().shadowImage
        nav.navigationBar.shadowImage = imageForBar
        nav.navigationBar.isTranslucent = true
    }
    
    func transitionToAssignmentScreen(link: String, title: String) {
        API.path = link
        guard
            let assignmentController: AssignmentScreenViewController = DependenceProvider.resolveWith(arg: "catalog"),
            let nav = catalogScreenViewController.navigationController else {
            objectDescription(self, function: #function)
            return }
        self.assignmentScreenViewController = assignmentController
        self.assignmentScreenViewController.navigationItem.title = title
        
        customizingNavigationBar(nav)
        nav.pushViewController(assignmentScreenViewController, animated: true)
    }
}

extension CatalogTabCoordinator: AssignmentScreenRouterInput {
    func transitionToProductScreen(with info: ItemCredential) {
        API.path = info.link
        guard
            let productController: ProductScreenViewController = DependenceProvider.resolveWith(arg: "catalog") else {
                objectDescription(self, function: #function)
                return }
        ItemProductScreen.productCredential = ProductCredential(from: info)
        self.titleProduct = info.titleItem
        productController.navigationItem.title = info.titleItem
        self.productScreenViewController = productController
        assignmentScreenViewController.navigationController?.pushViewController(productController, animated: true)
    }
}

extension CatalogTabCoordinator: ProductScreenRouterInput {
    func transitionToOrderScreen() {
        let vc = OrderScreenViewController(nibName: "OrderScreenViewController", bundle: Bundle(for: OrderScreenViewController.self))
        vc.productDescription = self.titleProduct
        assignmentScreenViewController.navigationController?.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
}

