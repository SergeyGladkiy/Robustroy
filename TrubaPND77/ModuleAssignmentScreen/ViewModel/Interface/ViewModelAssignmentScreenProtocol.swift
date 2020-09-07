//
//  ViewModelAssignmentScreen.swift
//  TrubaPND77
//
//  Created by Serg on 19.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

protocol ViewModelAssignmentScreenProtocol {
    var state: Observable<ViewModelAssignmentScreenState> { get }
    
    func getInformation()
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CellViewModelAssignmentScreen
    func getCredentialFor(item: IndexPath) -> ItemCredential 
}
