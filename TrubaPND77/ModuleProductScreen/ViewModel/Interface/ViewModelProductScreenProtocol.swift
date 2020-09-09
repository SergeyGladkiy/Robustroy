//
//  ViewModelProductScreenProtocol.swift
//  TrubaPND77
//
//  Created by Serg on 31.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

protocol ViewModelProductScreenProtocol {
    var state: Observable<ViewModelProductScreenState> { get }
    
    func getInformation()
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CellViewModelProductScreen?
}
