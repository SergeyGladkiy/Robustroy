//
//  ViewModelCatalogScreen.swift
//  TrubaPND77
//
//  Created by Serg on 10.09.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

class ViewModelCatalogScreen {
    private var model: ModelCatalogScreenProtocol
    var state: Observable<ViewModelCatalogScreenState>
    private var dictionaryOfItems = [Int: ItemCatalogScreen]()
    
    init(state: Observable<ViewModelCatalogScreenState>, model: ModelCatalogScreenProtocol) {
        self.state = state
        self.model = model
        twoWayDataBinding()
    }
    
    private func twoWayDataBinding() {
        model.errorOccured.bind { [weak self] (error) in
            guard let self = self else {
                print("ViewModelMainScreen is deinitialized")
                return
            }
            
            switch error {
            case .initial:
                return
            default:
                //MARK: to understand what the error is
                print(error)
                self.state.observable = .errorOccured(unknownError)
            }
        }
        
        model.staticInfoCatalog.bind { [weak self] (dict) in
            guard let self = self else {
                print("ViewModelMainScreen is deinitialized")
                return
            }
            
            if dict.isEmpty { return }
            self.dictionaryOfItems = dict
            self.state.observable = .readyToShowItems
        }
    }
}

extension ViewModelCatalogScreen: ViewModelCatalogScreenProtocol {
    func getInfoBarMenuView() -> [String] {
        let count = dictionaryOfItems.count
        let info = (0..<count).map {
            dictionaryOfItems[$0]!.groupTitle
        }
        return info
    }
    
    func getCatalogInfo() {
        model.processingStaticData()
    }
    
    func numberOfRows() -> Int {
        return dictionaryOfItems.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CellViewModelCatalogScreen? {
        let data = dictionaryOfItems[indexPath.row]
        guard let model = data else {
            objectDescription(self, function: #function)
            state.observable = .errorOccured(unknownError)
            return nil
        }
        let info = model.typesGroup
        return CellViewModelCatalogScreen(infoTypesGroup: info)
    }
    
    
}
