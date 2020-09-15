//
//  ViewModelCatalogScreenProtocol.swift
//  TrubaPND77
//
//  Created by Serg on 10.09.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

enum ViewModelCatalogScreenState {
    case initial
    case readyToShowItems
    case errorOccured(String)
}

protocol ViewModelCatalogScreenProtocol {
    var state: Observable<ViewModelCatalogScreenState> { get }
    func getCatalogInfo()
    func getInfoBarMenuView() -> [String]
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CellViewModelCatalogScreen?
}
