//
//  Observable.swift
//  TrubaPND77
//
//  Created by Serg on 29.07.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

class Observable<T> {
    var observable: T {
        didSet {
            onChanged?(observable)
        }
    }
    
    private var onChanged: ((T)-> Void)?
    
    init(observable: T) {
        self.observable = observable
    }
    
    func bind(bindingClosure: @escaping (T)-> Void) {
        bindingClosure(observable)
        self.onChanged = bindingClosure
    }
}
