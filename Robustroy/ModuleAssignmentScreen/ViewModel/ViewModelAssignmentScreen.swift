//
//  ViewModelAssignment.swift
//  TrubaPND77
//
//  Created by Serg on 19.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

enum ViewModelAssignmentScreenState {
    case initial
    case readyToShowItems
    case showLoader
    case errorOccured(String)
}

class ViewModelAssignmentScreen {
    private var readyAssignmentItems = [ItemAssignmentScreen]()
    
    private let model: ModelAssignmentScreenProtocol
    var state: Observable<ViewModelAssignmentScreenState>
    
    init(model: ModelAssignmentScreenProtocol, state: Observable<ViewModelAssignmentScreenState>) {
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
            
            if data.isEmpty { return }
            self.readyAssignmentItems = data
            self.state.observable = .readyToShowItems
        }
    }
    
}

extension ViewModelAssignmentScreen: ViewModelAssignmentScreenProtocol {
    
    func numberOfRows() -> Int {
        readyAssignmentItems.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CellViewModelAssignmentScreen {
        let model = readyAssignmentItems[indexPath.row]
        return CellViewModelAssignmentScreen(model:  model)
    }
    
    func getInformation() {
        state.observable = .showLoader
        model.fetchingInformation()
    }
    
    func getCredentialFor(index: IndexPath) -> ItemCredential {
        let item = readyAssignmentItems[index.row]
        return ItemCredential(from: item)
    }
    
}
