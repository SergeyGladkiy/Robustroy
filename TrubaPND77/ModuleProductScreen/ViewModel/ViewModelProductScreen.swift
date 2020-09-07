//
//  ViewModelProductScreen.swift
//  TrubaPND77
//
//  Created by Serg on 31.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

enum ViewModelProductScreenState {
    case initial
    case readyToShowItems
    case showLoader
    case errorOccured(String)
}

class ViewModelProductScreen {
    private let model: ModelProductScreenProtocol
    var state: Observable<ViewModelProductScreenState> 
    
    var readyProductItem: ItemProductScreen?
    
    init(model: ModelProductScreenProtocol, state: Observable<ViewModelProductScreenState>) {
        self.model = model
        self.state = state
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
            case .notConnectedToInternet:
                self.state.observable = .errorOccured("Нет соединения с интернетом")
            default:
                //MARK: to understand what the error is
                print(error)
                self.state.observable = .errorOccured(unknownError)
            }
        }
        
        model.dataSource.bind { [weak self] (data) in
            guard let self = self else {
                print("ViewModelMainScreen is deinitialized")
                return
            }
            
            if data == nil { return }
            self.readyProductItem = data
            self.state.observable = .readyToShowItems
        }
    }
}

extension ViewModelProductScreen: ViewModelProductScreenProtocol {
    func getInformation() {
        state.observable = .showLoader
        model.fetchingInformation()
    }
    
    func numberOfRows() -> Int {
        return readyProductItem?.descriptionProduct.count ?? 0
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CellViewModelProductScreen? {
        let description = readyProductItem?.descriptionProduct
        let cellViewModel = description?[indexPath.row]
        return cellViewModel
    }
    
    func cellViewModelForHeader() -> ProductCredential? {
        return ItemProductScreen.productCredential
    }
}
