//
//  ModelMainScreen.swift
//  TrubaPND77
//
//  Created by Serg on 29.07.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

class ModelMainScreen {
    private let fetcher: NetworkingMainScreen
    
    
    var errorOccure: Observable<CustomError> = Observable(observable: .initial)
    private var dictionaryItems = [Int: ItemMainScreen]()
    
    private func installingStaticInformation() -> Bool {
        guard let path = Bundle.main.path(forResource: "DataMainScreen", ofType: "plist") else {
            errorOccure.observable = .wrongFilePath
            return false
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: [])
            let decoder = PropertyListDecoder()
            let info = try decoder.decode([ItemMainScreen].self, from: data)
            _ = (0..<info.count).map { dictionaryItems[$0] = info[$0] }
        } catch {
            errorOccure.observable = .notConnectedToInternet
            return false
        }
        return true
    }
    
    init(networking: NetworkingMainScreen) {
        self.fetcher = networking
    }
}

extension ModelMainScreen: ModelMainScreenProtocol {
    func connectionCheck() {
        fetcher.fetchInformationAboutServer { (result) in
            switch result {
            case .success(_):
                let result = self.installingStaticInformation()
                
            case .failure(let error):
                print(error)
                if error == .notConnectedToInternet {
                    self.errorOccure.observable = .notConnectedToInternet
                }
            }
        }
    }
    
    func numberOfItems() -> Int {
        return dictionaryItems.count
    }
    

    func dataOfItem(number: Int) -> ItemMainScreen? {
        guard let info = dictionaryItems[number] else {
            errorOccure.observable = .showableError("Неизвестная ошибка 😫")
            return nil
        }
        return info
    }
}
