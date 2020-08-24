//
//  MainScreenCoordinatorInterface.swift
//  TrubaPND77
//
//  Created by Serg on 18.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

protocol MainScreenRouterInput {
    func transitionToAssignmentScreen(link: String, title: String)
}
