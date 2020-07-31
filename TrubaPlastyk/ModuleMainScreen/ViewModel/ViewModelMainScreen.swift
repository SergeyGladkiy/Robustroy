//
//  ViewModelMainScreen.swift
//  TrubaPND77
//
//  Created by Serg on 29.07.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

class ViewModelMainScreen {
    private let model: ModelMainScreenProtocol
    var state: Observable<ViewModelMainScreenState>
    
    init(state: Observable<ViewModelMainScreenState>, model: ModelMainScreenProtocol) {
        self.state = state
        self.model = model
        twoWayDataBinding()
    }
    
    private func twoWayDataBinding() {
        model.errorOccure.bind { [weak self] (error) in
            if error.isEmpty {
                return
            }
            
            self?.state.observable = .errorOccure(error)
        }
    }
}

extension ViewModelMainScreen: ViewModelMainScreenProtocol {
    func numberOfRows() -> Int {
        return model.numberOfItems()
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CellViewModelMainScreen? {
        let data = model.dataOfItem(number: indexPath.item)
        guard let model = data else { return nil }
        return CellViewModelMainScreen(model: model)
    }
}
