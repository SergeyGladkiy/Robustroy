//
//  ApplicationCoordinator.swift
//  TrubaPND77
//
//  Created by Serg on 18.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit

class ApplicationCoordinator {
    
    fileprivate func createTabBarController() -> UITabBarController? {
        let mainCoordinator: MainScreenCoordinatorProtocol? = DependenceProvider.resolve()
        
        guard let mainTabController = (mainCoordinator as? BasicRoutingCoordinatorProtocol)?.start() else {
            objectDescription(self, function: #function)
            return nil
        }
        
        let vc2 = UIViewController()
        vc2.view.backgroundColor = .yellow
        
        let vc3 = UIViewController()
        vc3.view.backgroundColor = .red
        
        let vc4 = UIViewController()
        vc4.view.backgroundColor = .green
        
        let array = [
            createNavController(viewController: mainTabController, title: "Главная", imageName: "house"),
            createNavController(viewController: vc2, title: "Today", imageName: "Каталог"),
            createNavController(viewController: vc3, title: "О компании", imageName: "info.circle"),
            createNavController(viewController: vc4, title: "Контакты", imageName: "location")
            
        ]
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = array
        //tabBarController.tabBar.tintColor = .red
        //tabBarController.tabBar.barTintColor = .white
        
        return tabBarController
    }
    
    fileprivate func createNavController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: imageName), selectedImage: UIImage(systemName: imageName + ".fill"))
        
        viewController.navigationItem.title = title
        viewController.view.backgroundColor = .white
        return navController
    }
}

extension ApplicationCoordinator: ApplicationCoordinatorProtocol {
    func prepareWindow(with scene: UIWindowScene) -> UIWindow {
        let window = UIWindow(windowScene: scene)
        window.rootViewController = self.createTabBarController()
        window.makeKeyAndVisible()
        return window
    }
}
