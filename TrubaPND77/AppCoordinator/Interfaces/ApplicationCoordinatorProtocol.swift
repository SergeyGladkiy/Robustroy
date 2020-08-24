//
//  ApplicationCoordinatorInterface.swift
//  TrubaPND77
//
//  Created by Serg on 18.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit


protocol ApplicationCoordinatorProtocol{
    func prepareWindow() -> UIWindow
    
    @available(iOS 13.0, *)
    func prepareWindow(with scene: UIWindowScene) -> UIWindow
}
